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
        VStack(spacing: 20) {
            SearchBar(viewModel: viewModel)
            if viewModel.isSearched {
                ResultView(viewModel: viewModel)
            } else {
                SearchPreview()
            }
        }
        .padding()
    }
}

#Preview {
    SearchView(viewModel: SearchViewModel(summonerSearchApi: MockSearchService()))
}
