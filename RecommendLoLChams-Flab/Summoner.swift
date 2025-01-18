//
//  Summoner.swift
//  RecommendLoLChams-Flab
//
//  Created by 김혜지 on 1/18/25.
//

import Foundation

// 소환사 모델 작성중...
struct Summoner: Identifiable {
    let id: UUID = UUID()
    let puuid: String
    let name: String
}
