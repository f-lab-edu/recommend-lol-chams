//
//  ContentView.swift
//  RecommendLoLChams-Flab
//
//  Created by 김혜지 on 1/7/25.
//

import SwiftUI

struct ContentView: View {
    @State private var keyword: String = ""
    @State private var results: [String] = []

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

            TextField("소환사 ID를 입력해 주세요", text: $keyword)

            if !keyword.isEmpty {
                Button {
                    keyword = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                }
            }
        }
    }

    private var searchView: some View {
        List(results, id: \.self) { item in
            itemRow(item)
        }
    }

    private func itemRow(_ content: String) -> some View {
        Text(content)
    }
}

#Preview {
    ContentView()
}
