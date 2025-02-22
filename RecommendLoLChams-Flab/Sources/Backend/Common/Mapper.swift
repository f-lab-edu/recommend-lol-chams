//
//  Mapper.swift
//  RecommendLoLChams-Flab
//
//  Created by 김혜지 on 2/14/25.
//

import Foundation

enum Mapper {
    static func map<T: Decodable>(from data: Data, to response: T.Type) throws -> T {
        return try JSONDecoder().decode(response, from: data)
    }
}
