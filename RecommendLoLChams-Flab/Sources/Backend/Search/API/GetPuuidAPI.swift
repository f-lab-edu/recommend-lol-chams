//
//  GetPuuidAPI.swift
//  RecommendLoLChams-Flab
//
//  Created by 김혜지 on 2/15/25.
//

import Foundation

struct GetPuuidAPI: RequestAPI {
    typealias Parameter = EmptyParameter
    typealias Response = PuuidDTO
        
    let url: URL?
    let headers: [String: String]
    let httpMethod: HTTPMethod
    let parameter: EmptyParameter?
    
    init(gameName: String, tagLine: String) {
        self.url = URL(string: "https://kr.api.riotgames.com/riot/account/v1/accounts/by-riot-id/\(gameName)/\(tagLine)")
        self.headers = [:]
        self.httpMethod = .get
        self.parameter = nil
    }
}
