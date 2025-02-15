//
//  SearchSummonerAPI.swift
//  RecommendLoLChams-Flab
//
//  Created by 김혜지 on 2/15/25.
//

import Foundation

struct SearchSummonerAPI: RequestAPI {
    typealias Parameter = EmptyParameter
    typealias Response = SummonerDTO
        
    let url: URL?
    let headers: [String: String]
    let httpMethod: HTTPMethod
    let parameter: EmptyParameter?
    
    init(name: String) throws {
        guard let token = Config.riotApiKey else { throw EnvironmentError.emptyApiKey }
        self.url = URL(string: "https://kr.api.riotgames.com/lol/summoner/v4/summoners/by-name/\(name)")
        self.headers = ["X-Riot-Token": token]
        self.httpMethod = .get
        self.parameter = nil
    }
    
    init(puuid: String) throws {
        guard let token = Config.riotApiKey else { throw EnvironmentError.emptyApiKey }
        self.url = URL(string: "https://kr.api.riotgames.com/lol/summoner/v4/summoners/\(puuid)")
        self.headers = ["X-Riot-Token": token]
        self.httpMethod = .get
        self.parameter = nil
    }
}
