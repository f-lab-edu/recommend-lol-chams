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
            logRequest(urlRequest)
            let (data, response) = try await session.data(for: urlRequest)
            logResponse(url: urlRequest.url, data: data, response: response)
            return data
        } catch {
            logError(error)
            throw error
        }
    }
    
    private func makeURLRequest(from api: some RequestAPI) throws -> URLRequest {
        guard let url = api.url else { throw HTTPError.invalidURL }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = api.httpMethod.rawValue
        if !api.headers.isEmpty {
            api.headers.forEach({ (key, value) in
                urlRequest.setValue(value, forHTTPHeaderField: key)
            })
        }
        if let parameter = api.parameter {
            urlRequest.httpBody = try? makeBody(with: parameter)
        }
        return urlRequest
    }
    
    private func makeBody(with parameter: Encodable) throws -> Data? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes]
        encoder.keyEncodingStrategy = .convertToSnakeCase
        
        let encoded = try encoder.encode(parameter)
        return encoded
    }
    
    private func makeTimestamp() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        dateFormatter.locale = Locale(identifier: "ko_KR")
        let dateString = dateFormatter.string(from: .now)
        return dateString
    }
    
    private func logRequest(_ urlRequest: URLRequest) {
        var headerString: String = "No Header"
        if let allHTTPHeaderFields = urlRequest.allHTTPHeaderFields {
            guard let prettyPrintedData = try? JSONSerialization.data(
                withJSONObject: allHTTPHeaderFields,
                options: [.prettyPrinted, .sortedKeys]
            ),
                  let prettyPrintedString = String(data: prettyPrintedData, encoding: .utf8) else { return }
            headerString = prettyPrintedString
        }
        
        var httpBodyString: String = "No Body"
        if let httpBodyData = urlRequest.httpBody {
            guard let object = try? JSONSerialization.jsonObject(with: httpBodyData),
                  let prettyPrintedData = try? JSONSerialization.data(
                    withJSONObject: object,
                    options: [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes]
                  ),
                  let prettyPrintedString = String(data: prettyPrintedData, encoding: .utf8) else { return }
            httpBodyString = prettyPrintedString
        }
        
        DLog.log(
            .info,
            subject: "Request Created",
            content:
            """
            Timestamp : \(makeTimestamp())
            URL       : \(urlRequest.url?.absoluteString ?? "Unknown")
            Method    : \(urlRequest.httpMethod ?? "Unknown")
            Headers   : \(headerString)
            Body      : \(httpBodyString)
            """
        )
    }
    
    private func logResponse(url: URL?, data: Data, response: URLResponse) {
        var code: Int?
        if let response = response as? HTTPURLResponse {
            code = response.statusCode
        }
        
        var responseString: String = "Empty Response"
        if let object = try? JSONSerialization.jsonObject(with: data),
           let prettyPrintedData = try? JSONSerialization.data(
            withJSONObject: object,
            options: [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes]
           ),
           let prettyPrintedString = String(data: prettyPrintedData, encoding: .utf8) {
            responseString = prettyPrintedString
        }
        
        DLog.log(
            .response,
            subject: "Received Response",
            content:
            """
            Timestamp : \(makeTimestamp())
            URL       : \(url?.absoluteString ?? "Unknown")
            Code      : \(code?.description ?? "Unknown")
            Response  : \(responseString)
            """
        )
    }
    
    private func logError(_ error: Error) {
        DLog.log(
            .error,
            subject: "Received Error",
            content:
            """
            Timestamp : \(makeTimestamp())
            Error     : \(error.localizedDescription)
            """
        )
    }
}
