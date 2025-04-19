//
//  Untitled.swift
//  RecommendLoLChams-Flab
//
//  Created by 김혜지 on 4/19/25.
//

struct Profile {
    let summoner: Summoner
    let ranks: [Rank]
}

extension Profile {
    static let mock = Profile(
        summoner: .mock,
        ranks: [.soloMock, .flexMock]
    )
}
