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
    @Published private(set) var ranks: [Rank] = []

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
            .sink { [weak self] _ in
                Task { @MainActor  in
                    self?.keyword = ""
                }
            }
            .store(in: &cancellables)
        
        searchSummoner
            .filter { !$0.isEmpty }
            .flatMap(maxPublishers: .max(1), fetchPuuid(keyword:))
            .flatMap(maxPublishers: .max(1), searchSummoner(puuid:))
            .flatMap(maxPublishers: .max(1), fetchRanks(summoner:))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                
            }, receiveValue: { [weak self] profile in
                Task { @MainActor in
                    self?.summoner = profile.summoner
                    self?.ranks = profile.ranks
                }
            })
            .store(in: &cancellables)
    }
    
    private func extract(from keyword: String) -> (String, String)? {
        let separated = keyword.components(separatedBy: "#")
        guard separated.count == 2 else { return nil }
        let gameName = separated[0]
        let tagLine = separated[1]
        return (gameName, tagLine)
    }
    
    private func fetchPuuid(keyword: String) -> AnyPublisher<String, Error> {
        Deferred {
            Future { promise in
                Task {
                    do {
                        guard let (gameName, tagLine) = self.extract(from: keyword) else { return }
                        let puuid = try await self.summonerSearchApi.fetchPuuid(gameName: gameName, tagLine: tagLine)
                        promise(.success(puuid))
                    } catch {
                        promise(.failure(error))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    private func searchSummoner(puuid: String) -> AnyPublisher<Summoner, Error> {
        Deferred {
            Future { promise in
                Task {
                    do {
                        let summoner = try await self.summonerSearchApi.searchSummoner(puuid: puuid)
                        promise(.success(summoner))
                    } catch {
                        promise(.failure(error))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    private func fetchRanks(summoner: Summoner) -> AnyPublisher<Profile, Error> {
        Deferred {
            Future { promise in
                Task {
                    do {
                        let ranks = try await self.summonerSearchApi.fetchRank(summonerId: summoner.id)
                        let profile = Profile(summoner: summoner, ranks: ranks)
                        promise(.success(profile))
                    } catch {
                        promise(.failure(error))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
