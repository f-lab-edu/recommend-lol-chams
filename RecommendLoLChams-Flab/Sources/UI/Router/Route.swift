//
//  Route.swift
//  RecommendLoLChams-Flab
//
//  Created by 김혜지 on 4/19/25.
//

import SwiftUI

enum Route: Hashable {
    case summonerDetail(profile: Profile)
}

extension Route {
    @ViewBuilder
    func view() -> some View {
        switch self {
        case .summonerDetail(let profile):
            SummonerDetailView(profile: profile)
        }
    }
}
