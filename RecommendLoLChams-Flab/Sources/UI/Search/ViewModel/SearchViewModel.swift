//
//  SearchViewModel.swift
//  RecommendLoLChams-Flab
//
//  Created by 김혜지 on 1/18/25.
//

import Combine
import Foundation

final class SearchViewModel: ObservableObject {
    @Published var keyword: String = ""
    @Published private(set) var summoner: Summoner?

    private let summonerSearchApi: SearchSummonerUseCase
    
    let clearKeyword: PassthroughSubject<Void, Never> = .init()
    let searchSummoner: PassthroughSubject<String, Never> = .init()
    private var cancellables: Set<AnyCancellable> = []

    init(summonerSearchApi: SearchSummonerUseCase) {
        self.summonerSearchApi = summonerSearchApi
        bind()
    }
    
    private func bind() {
        clearKeyword
            .receive(on: DispatchQueue.main)
            .sink { _ in
                Task { @MainActor [weak self] in
                    guard let self else { return }
                    self.keyword = ""
                }
            }
            .store(in: &cancellables)
        
        searchSummoner
            .filter { !$0.isEmpty }
            .flatMap { keyword in
                Future<Summoner?, Error> { promise in
                    Task { [weak self] in
                        guard let self else {
                            return promise(.failure(ApplicationError.selfIsNil))
                        }
                        
                        guard let (gameName, tagLine) = self.extract(from: keyword) else { return }
                        
                        do {
                            async let puuid = try await self.summonerSearchApi.getPuuid(gameName: gameName, tagLine: tagLine)
                            let summoner = try await self.summonerSearchApi.searchSummoner(puuid: puuid)
                            
                            return promise(.success(summoner))
                        } catch {
                            return promise(.failure(error))
                        }
                    }
                }
            }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { result in
                Task { @MainActor [weak self] in
                    guard let self else { return }
                    self.summoner = result
                }
            }
            .store(in: &cancellables)
    }
    
    private func extract(from keyword: String) -> (String, String)? {
        let separated = keyword.components(separatedBy: "#")
        guard separated.count == 2 else { return nil }
        let gameName = separated[0]
        let tagLine = separated[1]
        return (gameName, tagLine)
    }
}
