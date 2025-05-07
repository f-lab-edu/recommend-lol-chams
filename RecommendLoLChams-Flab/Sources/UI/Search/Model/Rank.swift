//
//  Rank.swift
//  RecommendLoLChams-Flab
//
//  Created by 김혜지 on 4/18/25.
//

import Foundation

struct Rank: Identifiable, Hashable {
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
    
    var imageAsset: ImageAsset {
        switch self {
        case .iron:
            Asset.icIron
        case .bronze:
            Asset.icBronze
        case .silver:
            Asset.icSilver
        case .gold:
            Asset.icGold
        case .platinum:
            Asset.icPlatinum
        case .diamond:
            Asset.icDiamond
        case .master:
            Asset.icMaster
        case .grandmaster:
            Asset.icGrandmaster
        case .challenger:
            Asset.icChallenger
        }
    }
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

extension Rank {
    static let soloMock = Rank(tier: .challenger, rank: .i, queue: .solo5x5, wins: 30, loses: 1, isHotStreak: true)
    static let flexMock = Rank(tier: .challenger, rank: .iii, queue: .flexSr, wins: 24, loses: 3, isHotStreak: true)
}
