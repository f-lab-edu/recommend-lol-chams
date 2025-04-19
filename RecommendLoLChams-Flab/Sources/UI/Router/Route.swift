//
//  Route.swift
//  RecommendLoLChams-Flab
//
//  Created by 김혜지 on 4/19/25.
//

import SwiftUI

enum Route: Hashable {
    case record // 상세 전적
}

extension Route {
    @ViewBuilder
    func view() -> some View {
        switch self {
        case .record:
            EmptyView()
        }
    }
}
