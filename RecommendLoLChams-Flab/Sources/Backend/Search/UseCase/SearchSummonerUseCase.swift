//
//  SearchSummonerUseCase.swift
//  RecommendLoLChams-Flab
//
//  Created by 김혜지 on 1/18/25.
//

protocol SearchSummonerUseCase {
    func getPuuid(gameName: String, tagLine: String) async throws -> String
    func searchSummoner(puuid: String) async throws -> Summoner
    func getLeagues(summonerId: String) async throws -> [League]
}
