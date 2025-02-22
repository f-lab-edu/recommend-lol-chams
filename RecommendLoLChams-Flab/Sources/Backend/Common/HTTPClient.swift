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

// TODO: 이미 호출하고 아직 response를 받지 못한 url의 경우 다시 호출하지 않도록 처리 -> 프로젝트에 큰 기여는 없지만 업무시 참고하기 위함
struct LiveHTTPClient: HTTPClient {
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func fetch(from api: some RequestAPI) async throws -> Data {
        do {
            let urlRequest = try makeURLRequest(from: api)
            let (data, response) = try await session.data(for: urlRequest)
            return data
        } catch {
            print("Failed : \(error.localizedDescription)")
            throw error
        }
    }
    
    private func makeURLRequest(from api: some RequestAPI) throws -> URLRequest {
        guard let url = api.url else { throw HTTPError.invalidURL }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = api.httpMethod.rawValue
        api.headers.forEach({ (key, value) in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        })
        urlRequest.httpBody = try? makeBody(with: api.parameter)
        return urlRequest
    }
    
    private func makeBody(with parameter: Encodable) throws -> Data {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes]
        encoder.keyEncodingStrategy = .convertToSnakeCase
        
        let encoded = try encoder.encode(parameter)
        print(String(data: encoded, encoding: .utf8) ?? "Failed encoding to String")
        return encoded
    }
}
