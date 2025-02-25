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
    
    func getPuuid(gameName: String, tagLine: String) async throws -> String {
        let api = try GetPuuidAPI(gameName: gameName, tagLine: tagLine)
        let data = try await client.fetch(from: api)
        guard let dto = try? Mapper.map(from: data, to: api.response) else { throw HTTPError.invalidData }
        return dto.puuid
    }
    
    func searchSummoner(puuid: String) async throws -> Summoner {
        let api = try SearchSummonerAPI(puuid: puuid)
        let data = try await client.fetch(from: api)
        guard let dto = try? Mapper.map(from: data, to: api.response) else { throw HTTPError.invalidData }
        return dto.toModel()
    }
    
    func getLeagues(summonerId: String) async throws -> [League] {
        let api = try GetLeagueAPI(summonerId: summonerId)
        let data = try await client.fetch(from: api)
        guard let dto = try? Mapper.map(from: data, to: api.response) else { throw HTTPError.invalidData }
        return dto.toModel()
    }
    
    func isPlaying(puuid: String) async throws -> Bool {
        do {
            let api = try IsPlayingAPI(puuid: puuid)
            let _ = try await client.fetch(from: api)
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
