//
//  GetMatchIdAPI.swift
//  RecommendLoLChams-Flab
//
//  Created by 김혜지 on 2/22/25.
//

import Foundation

struct GetMatchIdAPI: RequestAPI {
    typealias Parameter = EmptyParameter
    typealias Response = [String]
    
    let url: URL?
    let headers: [String: String]
    let httpMethod: HTTPMethod
    let parameter: EmptyParameter?
    
    init(puuid: String, startIndex: Int, count: Int) throws {
        guard let token = Config.riotApiKey else { throw EnvironmentError.emptyApiKey }
        self.url = URL(string: "https://asia.api.riotgames.com/lol/match/v5/matches/by-puuid/\(puuid)/ids?start=\(startIndex)&count=\(count)")
        self.headers = ["X-Riot-Token": token]
        self.httpMethod = .get
        self.parameter = nil
    }
}
