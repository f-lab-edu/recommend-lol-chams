//
//  RankDTO.swift
//  RecommendLoLChams-Flab
//
//  Created by 김혜지 on 4/18/25.
//

struct RankDTO: Decodable {
    let tier: String        // 티어(IRON, SILVER, ...)
    let rank: String        // 등급(I, II, ...)
    let queueType: String   // 큐 타입(RANKED_SOLO_5x5, RANKED_FLEX_SR)
    let wins: Int           // 승리 수
    let loses: Int          // 패배 수
    let hotStreak: Bool     // 연승 여부
}
