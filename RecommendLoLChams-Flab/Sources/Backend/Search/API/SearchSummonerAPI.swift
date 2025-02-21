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
    
    init(name: String) {
        self.url = URL(string: "https://kr.api.riotgames.com/lol/summoner/v4/summoners/by-name/\(name)")
        self.headers = [:]
        self.httpMethod = .get
        self.parameter = nil
    }
    
    init(puuid: String) {
        self.url = URL(string: "https://kr.api.riotgames.com/lol/summoner/v4/summoners/\(puuid)")
        self.headers = [:]
        self.httpMethod = .get
        self.parameter = nil
    }
}
