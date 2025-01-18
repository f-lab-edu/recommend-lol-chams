//
//  HTTPClient.swift
//  RecommendLoLChams-Flab
//
//  Created by 김혜지 on 1/18/25.
//

import Foundation

protocol HTTPClient {
    func fetch(from url: URL) async throws -> Data
}

struct LiveHTTPClient: HTTPClient {
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func fetch(from url: URL) async throws -> Data {
        let (data, response) = try await session.data(from: url)
        print("url: \(url)")
        print("data: \(String(data: data, encoding: .utf8))")
        return data
    }
}
