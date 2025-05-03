//
//  SearchService.swift
//  RecommendLoLChams-Flab
//
//  Created by 김혜지 on 2/15/25.
//

struct SearchService: SearchSummonerUseCase {
    private let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    func fetchPuuid(gameName: String, tagLine: String) async throws -> String {
        let api = try GetPuuidAPI(gameName: gameName, tagLine: tagLine)
        let data = try await client.fetch(from: api)
        guard let dto = try? Mapper.map(from: data, to: api.response) else { throw HTTPError.invalidData }
        return dto.puuid
    }
    
    func searchSummoner(puuid: String) async throws -> Summoner {
        let api = try GetSummonerAPI(puuid: puuid)
        let data = try await client.fetch(from: api)
        guard let dto = try? Mapper.map(from: data, to: api.response) else { throw HTTPError.invalidData }
        return dto.toModel()
    }
    
    func fetchRank(summonerId: String) async throws -> [Rank] {
        let api = try GetRankAPI(summonerId: summonerId)
        let data = try await client.fetch(from: api)
        guard let dto = try? Mapper.map(from: data, to: api.response) else { throw HTTPError.invalidData }
        return dto.toModel()
    }
    
    func fetchMatchIds(puuid: String, startIndex: Int) async throws -> [String] {
        let api = try GetMatchIdAPI(puuid: puuid, startIndex: startIndex, count: 10)
        let data = try await client.fetch(from: api)
        guard let dto = try? Mapper.map(from: data, to: api.response) else { throw HTTPError.invalidData }
        return dto
    }
    
    func isPlaying(puuid: String) async throws -> Bool {
        do {
            let api = try IsPlayingAPI(puuid: puuid)
            _ = try await client.fetch(from: api)
            return true
        } catch HTTPError.statusCode(404) {
            return false
        } catch {
            throw error
        }
    }
}

// MARK: - Modeling

private extension SummonerDTO {
    func toModel() -> Summoner {
        Summoner(
            id: id,
            puuid: puuid,
            accountId: accountId,
            summonerLevel: summonerLevel
        )
    }
}

private extension LeagueDTO {
    func toModel() -> League? {
        guard let queueType = League.QueueType(rawValue: queueType) else { return nil }
        return League(
            leagueId: leagueId,
            queueType: queueType,
            tier: tier,
            rank: rank,
            wins: wins,
            loses: loses
        )
    }
}

private extension Array where Element == LeagueDTO {
    func toModel() -> [League] {
        compactMap({ $0.toModel() })
    }
}

private extension RankDTO {
    func toModel() -> Rank? {
        guard let tier = Tier(rawValue: tier.lowercased()),
              let rank = RankNum(rawValue: rank.lowercased()),
              let queue = Queue(rawValue: queueType) else { return nil }
        return Rank(
            tier: tier,
            rank: rank,
            queue: queue,
            wins: wins,
            loses: loses,
            isHotStreak: hotStreak
        )
    }
}

private extension Array where Element == RankDTO {
    func toModel() -> [Rank] {
        compactMap({ $0.toModel() })
    }
}
