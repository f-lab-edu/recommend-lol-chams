//
//  GetLeagueAPI.swift
//  RecommendLoLChams-Flab
//
//  Created by 김혜지 on 2/22/25.
//

import Foundation

struct GetLeagueAPI: RequestAPI {
    typealias Parameter = EmptyParameter
    typealias Response = [LeagueDTO]
    
    let url: URL?
    let headers: [String: String]
    let httpMethod: HTTPMethod
    let parameter: EmptyParameter?
    
    init(summonerId: String) throws {
        guard let token = Config.riotApiKey else { throw EnvironmentError.emptyApiKey }
        self.url = URL(string: "https://kr.api.riotgames.com/lol/league/v4/entries/by-summoner/\(summonerId)")
        self.headers = ["X-Riot-Token": token]
        self.httpMethod = .get
        self.parameter = nil
    }
}
