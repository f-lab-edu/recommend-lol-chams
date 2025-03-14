//
//  SearchBar.swift
//  RecommendLoLChams-Flab
//
//  Created by 김혜지 on 3/15/25.
//

import SwiftUI

struct SearchBar: View {
    @ObservedObject private var viewModel: SearchViewModel
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack {
            Image(asset: Asset.iconSearch)
                .resizable()
                .frame(width: 25, height: 25)
            
            TextField(L10n.SummonerSearch.searchbarPlaceholder.value, text: $viewModel.keyword)
            
            if !viewModel.keyword.isEmpty {
                Button {
                    viewModel.clearKeyword.send()
                } label: {
                    Image(asset: Asset.iconClear)
                        .resizable()
                        .frame(width: 20, height: 20)
                }
            }
            
            Button {
                viewModel.searchSummoner.send(viewModel.keyword)
            } label: {
                L10n.SummonerSearch.searchbarButtonTitle.text
                    .bold()
            }
            .disabled(viewModel.keyword.isEmpty)
            .tint(Color.Palette.blue5)
        }
    }
}
