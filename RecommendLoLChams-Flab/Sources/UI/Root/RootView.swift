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
            SearchView(viewModel: SearchViewModel(summonerSearchApi: SearchService(client: LiveHTTPClient())))
                .tabItem {
                    VStack {
                        Image(systemName: "magnifyingglass")
                        L10n.Tab.searchScore.text
                    }
                }
            RecommendView()
                .tabItem {
                    VStack {
                        Image(systemName: "lasso.badge.sparkles")
                        L10n.Tab.recommendChampion.text
                    }
                }
        }
    }
}

#Preview {
    RootView()
}
