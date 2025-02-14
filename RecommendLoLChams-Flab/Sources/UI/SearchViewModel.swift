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
    @Published private(set) var summoners: [Summoner] = []

    private let summonerSearchApi: SummonerSearchUseCase
    
    let clearKeyword: PassthroughSubject<Void, Never> = .init()
    let searchSummoner: PassthroughSubject<String, Never> = .init()
    private var cancellables: Set<AnyCancellable> = []

    init(summonerSearchApi: SummonerSearchUseCase) {
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
                Future<[Summoner], Error> { promise in
                    Task { [weak self] in
                        guard let self else {
                            return promise(.failure(ApplicationError.selfIsNil))
                        }
                        
                        do {
                            let summoners = try await self.summonerSearchApi.searchSummoner(name: keyword)
                            return promise(.success(summoners))
                        } catch {
                            return promise(.failure(error))
                        }
                    }
                }
            }
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .sink { result in
                Task { @MainActor [weak self] in
                    guard let self else { return }
                    self.summoners = result
                }
            }
            .store(in: &cancellables)
    }
}
