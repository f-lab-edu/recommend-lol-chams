//
//  SearchSummonerUseCase.swift
//  RecommendLoLChams-Flab
//
//  Created by 김혜지 on 1/18/25.
//

protocol SearchSummonerUseCase {
    func fetchPuuid(gameName: String, tagLine: String) async throws -> String
    func searchSummoner(puuid: String) async throws -> Summoner
    func fetchRank(summonerId: String) async throws -> [Rank]
    func fetchLeagues(summonerId: String) async throws -> [League]
    func isPlaying(puuid: String) async throws -> Bool
}
