//
//  SearchView.swift
//  RecommendLoLChams-Flab
//
//  Created by 김혜지 on 1/7/25.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel: SearchViewModel

    init(viewModel: SearchViewModel) {
        self.viewModel = SearchViewModel(summonerSearchApi: SearchService(client: LiveHTTPClient()))
    }

    var body: some View {
        VStack(alignment: .leading) {
            searchBar
            searchView
        }
        .padding()
    }

    private var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")

            TextField("소환사 ID를 입력해 주세요", text: $viewModel.keyword)

            if !viewModel.keyword.isEmpty {
                Button {
                    viewModel.clearKeyword.send()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                }
            }

            Button("검색") {
                viewModel.searchSummoner.send(viewModel.keyword)
            }
            .disabled(viewModel.keyword.isEmpty)
        }
    }

    private var searchView: some View {
        List(viewModel.summoners) { summoner in
            itemRow(summoner.name)
        }
    }

    private func itemRow(_ content: String) -> some View {
        Text(content)
    }
}

#Preview {
    SearchView(viewModel: SearchViewModel(summonerSearchApi: MockSearchService()))
}
