//
//  RootView.swift
//  RecommendLoLChams-Flab
//
//  Created by 김혜지 on 1/17/25.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            SearchView(viewModel: SearchViewModel(summonerSearchApi: SummonerSearchService(client: LiveHTTPClient())))
                .tabItem {
                    VStack {
                        Image(systemName: "magnifyingglass")
                        Text("전적검색")
                    }
                }
            RecommendView()
                .tabItem {
                    VStack {
                        Image(systemName: "lasso.badge.sparkles")
                        Text("챔피언 추천")
                    }
                }
        }
    }
}

#Preview {
    RootView()
}
