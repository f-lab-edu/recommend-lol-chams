//
//  SearchViewModel.swift
//  RecommendLoLChams-Flab
//
//  Created by 김혜지 on 1/18/25.
//

import Foundation

final class SearchViewModel: ObservableObject {
    @Published var keyword: String = ""
    @Published private(set) var summoners: [Summoner] = []

    private let userSearchAPI: SummonerSearchAPI

    init(userSearchAPI: SummonerSearchAPI) {
        self.userSearchAPI = userSearchAPI
    }

    @MainActor
    func clearKeyword() {
        keyword = ""
    }

    func search() async {
        do {
            let summoners = try await userSearchAPI.searchUser(id: keyword)
            await MainActor.run {
                self.summoners = summoners
            }
        } catch {
            print("error: \(error.localizedDescription)")
        }
    }
}
