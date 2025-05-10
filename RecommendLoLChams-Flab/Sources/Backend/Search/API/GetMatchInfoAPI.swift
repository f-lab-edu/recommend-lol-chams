//
//  GetMatchInfoAPI.swift
//  RecommendLoLChams-Flab
//
//  Created by 김혜지 on 5/4/25.
//

import Foundation

struct GetMatchInfoAPI: RequestAPI {
    typealias Parameter = EmptyParameter
    typealias Response = MatchDTO
    
    let url: URL?
    let headers: [String: String]
    let httpMethod: HTTPMethod
    let parameter: EmptyParameter?
    
    init(matchId: String) throws {
        guard let token = Config.riotApiKey else { throw EnvironmentError.emptyApiKey }
        self.url = URL(string: "https://asia.api.riotgames.com/lol/match/v5/matches/\(matchId)")
        self.headers = ["X-Riot-Token": token]
        self.httpMethod = .get
        self.parameter = nil
    }
}
