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
        return Summoner(puuid: "", summonerLevel: 1)
    }
    
    func searchSummoner(name: String) async throws -> Summoner {
        return Summoner(puuid: "", summonerLevel: 1)
    }
}
