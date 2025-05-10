//
//  MatchDTO.swift
//  RecommendLoLChams-Flab
//
//  Created by 김혜지 on 2/22/25.
//

struct MatchDTO: Decodable {
    let info: Info
}

extension MatchDTO {
    struct Info: Decodable {
        let gameDuration: Int                   // 게임 진행 시간(초단위)
        let participants: [Participant]         // 10명의 모든 소환사 세부 전적
        let queueId: Int                        // 큐 ID
    }
}

extension MatchDTO {
    struct Participant: Decodable {
        let puuid: String                       // 유저 고유 ID
        let summonerName: String                // 소환사 이름
        let championId: Int                     // 플레이한 챔피언 ID
        let championName: String                // 플레이한 챔피언 이름
        let individualPosition: String          // 포지션 (TOP, JUNGLE, MIDDLE, BOTTOM, UTILITY)
        let kills: Int                          // 킬
        let deaths: Int                         // 데스
        let assists: Int                        // 어시
        let win: Bool                           // 승리 여부
        let totalDamageDealtToChampions: Int    // 챔피언에게 입힌 총 피해량
        let goldEarned: Int                     // 획득 골드량
        let item0: Int?                         // 빌드 아이템1
        let item1: Int?                         // 빌드 아이템2
        let item2: Int?                         // 빌드 아이템3
        let item3: Int?                         // 빌드 아이템4
        let item4: Int?                         // 빌드 아이템5
        let item5: Int?                         // 빌드 아이템5
        let item6: Int?                         // 빌드 아이템6
    }
}
