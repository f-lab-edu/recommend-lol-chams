//
//  RequestAPI.swift
//  RecommendLoLChams-Flab
//
//  Created by 김혜지 on 2/14/25.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

protocol RequestAPI {
    associatedtype Parameter: Encodable
    associatedtype Response: Decodable
    
    var url: URL? { get }
    var headers: [String: String] { get }
    var httpMethod: HTTPMethod { get }
    var parameter: Parameter? { get }
}
