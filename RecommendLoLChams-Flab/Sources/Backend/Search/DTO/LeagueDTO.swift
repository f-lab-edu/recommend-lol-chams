//
//  LeagueDTO.swift
//  RecommendLoLChams-Flab
//
//  Created by 김혜지 on 2/22/25.
//

struct LeagueDTO: Decodable {
    let leagueId: String
    let queueType: String
    let tier: String        // SILVER/GOLD
    let rank: String        // II/IV
    let wins: Int
    let loses: Int
}

extension LeagueDTO {
    func toModel() -> League {
        League(
            leagueId: leagueId,
            queueType: queueType,
            tier: tier,
            rank: rank,
            wins: wins,
            loses: loses
        )
    }
}
