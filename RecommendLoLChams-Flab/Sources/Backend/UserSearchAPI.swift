//
//  UserSearchAPI.swift
//  RecommendLoLChams-Flab
//
//  Created by 김혜지 on 1/18/25.
//

import Foundation

protocol UserSearchAPI {
    func searchUser(id: String) async throws
}

struct UserSearchService: UserSearchAPI {
    private let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    func searchUser(id: String) async throws { 
        guard let url = URL(string: "https://kr.api.riotgames.com/lol/summoner/v4/summoners/by-name/\(id)") else { return }
        let data = try await client.fetch(from: url)
    }
}
