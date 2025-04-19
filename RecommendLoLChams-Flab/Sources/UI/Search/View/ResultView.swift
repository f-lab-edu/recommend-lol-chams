//
//  ResultView.swift
//  RecommendLoLChams-Flab
//
//  Created by 김혜지 on 3/15/25.
//

import SwiftUI

struct ResultView: View {
    @ObservedObject private var viewModel: SearchViewModel
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        if let profile = viewModel.profile {
            SummonerView(profile: profile)
        } else {
            EmptyView()
        }
    }
}

private struct EmptyView: View {
    init() {}
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            Image(asset: Asset.imageSearchEmpty)
                .resizable()
                .frame(width: 50, height: 50)
            L10n.SummonerSearch.empty.text
                .font(.system(size: 15))
                .foregroundStyle(Color.Palette.blue7)
            Spacer()
        }
    }
}
