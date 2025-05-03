//
//  MockSearchService.swift
//  RecommendLoLChams-Flab
//
//  Created by 김혜지 on 2/15/25.
//

struct MockSearchService: SearchSummonerUseCase {
    func fetchPuuid(gameName: String, tagLine: String) async throws -> String {
        return ""
    }
    
    func searchSummoner(puuid: String) async throws -> Summoner {
        return Summoner(id: "", puuid: "", accountId: "", summonerLevel: 0)
    }
    
    func fetchRank(summonerId: String) async throws -> [Rank] {
        return [
            Rank(
                tier: .bronze,
                rank: .i,
                queue: .solo5x5,
                wins: 1,
                loses: 4,
                isHotStreak: false
            )
        ]
    }
    
    func fetchMatchIds(puuid: String, startIndex: Int) async throws -> [String] {
        return []
    }
    
    func isPlaying(puuid: String) async throws -> Bool {
        return true
    }
}
