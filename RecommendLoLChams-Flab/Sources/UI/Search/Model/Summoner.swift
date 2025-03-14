//
//  Summoner.swift
//  RecommendLoLChams-Flab
//
//  Created by 김혜지 on 1/18/25.
//

import Foundation

struct Summoner {
    var gameName: String = ""
    var tagLine: String = ""
    let id: String
    let puuid: String
    let accountId: String
    let summonerLevel: Int
    let profileIconId: Int
    var profileImageURL: URL? {
        let urlString = "http://ddragon.leagueoflegends.com/cdn/10.11.1/img/profileicon/\(profileIconId).png"
        return URL(string: urlString)
    }
    
    var isPlaying: Bool = false
}

extension Summoner {
    static let mock: Summoner = Summoner(
        gameName: "김덕배",
        tagLine: "#5066",
        id: "",
        puuid: "",
        accountId: "",
        summonerLevel: 10,
        profileIconId: 29
    )
}
