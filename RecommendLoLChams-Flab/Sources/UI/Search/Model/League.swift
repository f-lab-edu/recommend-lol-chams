//
//  League.swift
//  RecommendLoLChams-Flab
//
//  Created by 김혜지 on 2/22/25.
//

struct League {
    let leagueId: String
    let queueType: QueueType
    let tier: String
    let rank: String
    // TODO: tier icon
    let wins: Int
    let loses: Int
}

extension League {
    enum QueueType: String {
        case soloOrDuo = "RANKED_SOLO_5x5"
        case team = "RANKED_FLEX_SR"
        
        var korean: String {
            switch self {
            case .soloOrDuo:
                return "개인/2인 랭크"
            case .team:
                return "자유 랭크 구분"
            }
        }
    }
}
