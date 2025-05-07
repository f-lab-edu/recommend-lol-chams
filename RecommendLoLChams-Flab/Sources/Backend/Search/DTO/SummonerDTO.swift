//
//  SummonerDTO.swift
//  RecommendLoLChams-Flab
//
//  Created by 김혜지 on 1/18/25.
//

struct SummonerDTO: Decodable {
    let id: String
    let accountId: String
    let puuid: String
    let profileIconId: Int
    let revisionDate: Int
    let summonerLevel: Int
}
