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
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
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
            
            TextField(L10n.SummonorSearch.searchbarPlaceholder.value, text: $viewModel.keyword)
            
            if !viewModel.keyword.isEmpty {
                Button {
                    viewModel.clearKeyword.send()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                }
            }
            
            Button(L10n.SummonorSearch.searchbarButtonTitle.value) {
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
            VStack(spacing: 30) {
                Spacer()
                Image(systemName: "exclamationmark.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                Text(L10n.SummonorSearch.empty.value)
                Spacer()
            }
        }
    }
}

#Preview {
    SearchView(viewModel: SearchViewModel(summonerSearchApi: MockSearchService()))
}
