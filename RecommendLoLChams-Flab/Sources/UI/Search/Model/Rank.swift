//
//  Rank.swift
//  RecommendLoLChams-Flab
//
//  Created by 김혜지 on 4/18/25.
//

// swiftlint:disable all

import Foundation

struct Rank: Identifiable {
    let id = UUID()
    let tier: Tier
    let rank: RankNum
    let queue: Queue
    let wins: Int
    let loses: Int
    let isHotStreak: Bool
}

enum Tier: String {
    case iron
    case bronze
    case silver
    case gold
    case platinum
    case diamond
    case master
    case grandmaster
    case challenger
}

enum RankNum: String {
    case i, ii, iii, iv
}

enum Queue: String, CustomStringConvertible {
    case solo5x5 = "RANKED_SOLO_5x5"
    case flexSr = "RANKED_FLEX_SR"
    
    var description: String {
        switch self {
        case .solo5x5:
            "솔로 랭크 5:5"
        case .flexSr:
            "자유 랭크 솔로/듀오"
        }
    }
}

// swiftlint:enable all
