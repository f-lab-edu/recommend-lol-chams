//
//  Summoner.swift
//  RecommendLoLChams-Flab
//
//  Created by 김혜지 on 1/18/25.
//

import Foundation

struct Summoner: Hashable {
    var gameName: String = ""
    var tagLine: String = ""
    let id: String
    let puuid: String
    let accountId: String
    let profileIconId: Int
    var profileImageURL: URL? {
        let urlString = "https://ddragon.leagueoflegends.com/cdn/10.11.1/img/profileicon/\(profileIconId).png"
        return URL(string: urlString)
    }
    
    var isPlaying: Bool = false
}

extension Summoner {
    static let mock: Summoner = Summoner(
        gameName: "갈팡질팡바드",
        tagLine: "KR11",
        id: "",
        puuid: "",
        accountId: "",
        profileIconId: 1437
    )
}
