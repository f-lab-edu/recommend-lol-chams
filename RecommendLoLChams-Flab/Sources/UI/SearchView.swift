//
//  SearchView.swift
//  RecommendLoLChams-Flab
//
//  Created by 김혜지 on 1/7/25.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject private var viewModel: SearchViewModel

    init(viewModel: SearchViewModel) {
        self.viewModel = SearchViewModel(summonerSearchApi: SearchService(client: LiveHTTPClient()))
    }

    var body: some View {
        VStack(alignment: .leading) {
            SearchBar(viewModel: viewModel)
            ResultView(viewModel: viewModel)
        }
        .padding()
    }
}

private struct SearchBar: View {
    @ObservedObject private var viewModel: SearchViewModel

    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
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
}

private struct ResultView: View {
    @ObservedObject private var viewModel: SearchViewModel
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        if let summoner = viewModel.summoner {
            HStack {
                Text("puuid: \(summoner.puuid)")
                Spacer()
                Text("Lv. \(summoner.summonerLevel)")
            }
        } else {
            VStack {
                Spacer()
                Image("exclamationmark.circle.fill")
                Spacer()
                Text("해당하는 소환사가 없습니다!")
                Spacer()
            }
        }
    }
}

#Preview {
    SearchView(viewModel: SearchViewModel(summonerSearchApi: MockSearchService()))
}
