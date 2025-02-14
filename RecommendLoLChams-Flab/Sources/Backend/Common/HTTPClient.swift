//
//  HTTPClient.swift
//  RecommendLoLChams-Flab
//
//  Created by 김혜지 on 1/18/25.
//

import Foundation

protocol HTTPClient {
    func fetch(from api: some RequestAPI) async throws -> Data
}

struct LiveHTTPClient: HTTPClient {
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func fetch(from api: some RequestAPI) async throws -> Data {
        let urlRequest = try makeURLRequest(from: api)
        let (data, response) = try await session.data(for: urlRequest)
        return data
    }
    
    private func makeURLRequest(from api: some RequestAPI) throws -> URLRequest {
        guard let url = api.url else { throw HTTPError.invalidURL }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = api.httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = api.headers
        urlRequest.httpBody = try JSONEncoder().encode(api.parameter)
        return urlRequest
    }
}


