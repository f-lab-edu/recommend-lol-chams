//
//  MockSearchService.swift
//  RecommendLoLChams-Flab
//
//  Created by 김혜지 on 2/15/25.
//

struct MockSearchService: SearchSummonerUseCase {
    func getPuuid(gameName: String, tagLine: String) async throws -> String {
        return ""
    }
    
    func searchSummoner(puuid: String) async throws -> Summoner {
        return .mock
    }
    
    func getLeagues(summonerId: String) async throws -> [League] {
        return [
            League(
                leagueId: "1",
                queueType: .soloOrDuo,
                tier: "",
                rank: "",
                wins: 0,
                loses: 0
            )
        ]
    }
    
    func isPlaying(puuid: String) async throws -> Bool {
        return true
    }
}
