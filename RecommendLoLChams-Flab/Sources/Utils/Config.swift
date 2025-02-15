//
//  Config.swift
//  RecommendLoLChams-Flab
//
//  Created by 김혜지 on 2/15/25.
//

import Foundation

enum Config {
    private enum Keys: String {
        case riotApiKey = "RIOT_API_KEY"
        case openAiApiKey = "OPENAI_API_KEY"
    }
    
    private static let infoDictionary: [String: Any] = {
        return Bundle.main.infoDictionary ?? [:]
    }()
    
    static let riotApiKey: String? = {
        return infoDictionary[Keys.riotApiKey.rawValue] as? String
    }()
    static let openAiApiKey: String? = {
        return infoDictionary[Keys.openAiApiKey.rawValue] as? String
    }()
}
