//
//  IsPlayingAPI.swift
//  RecommendLoLChams-Flab
//
//  Created by 김혜지 on 2/26/25.
//

import Foundation

struct IsPlayingAPI: RequestAPI {
    typealias Parameter = EmptyParameter
    typealias Response = EmptyResponse
    
    let url: URL?
    let headers: [String: String]
    let httpMethod: HTTPMethod
    let parameter: EmptyParameter?
    
    init(puuid: String) throws {
        guard let token = Config.riotApiKey else { throw EnvironmentError.emptyApiKey }
        self.url = URL(string: "https://kr.api.riotgames.com/lol/spectator/v5/active-games/by-summoner/\(puuid)")
        self.headers = ["X-Riot-Token": token]
        self.httpMethod = .get
        self.parameter = nil
    }
}
