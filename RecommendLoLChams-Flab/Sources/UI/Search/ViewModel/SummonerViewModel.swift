//
//  SummonerViewModel.swift
//  RecommendLoLChams-Flab
//
//  Created by 김혜지 on 3/15/25.
//

import Combine
import Foundation

final class SummonerViewModel: ObservableObject {
    @Published private(set) var isPlaying: Bool = false
    let profile: Profile
    
    private let summonerSearchApi: SearchSummonerUseCase
    
    let checkPlaying: PassthroughSubject<Void, Never> = PassthroughSubject()
    private var cancellables: Set<AnyCancellable> = []
    
    init(summonerSearchApi: SearchSummonerUseCase, profile: Profile) {
        self.summonerSearchApi = summonerSearchApi
        self.profile = profile
        bind()
    }
    
    private func bind() {
        checkPlaying
            .flatMap { _ in
                Future<Bool, Error> { promise in
                    Task { [weak self] in
                        guard let self else {
                            return promise(.failure(ApplicationError.selfIsNil))
                        }
                        
                        do {
                            guard !profile.summoner.puuid.isEmpty else { return }
                            async let isPlaying = try await self.summonerSearchApi.isPlaying(puuid: profile.summoner.puuid)
                            return promise(.success(try await isPlaying))
                        } catch {
                            return promise(.failure(error))
                        }
                    }
                }
            }
            .replaceError(with: false)
            .receive(on: DispatchQueue.main)
            .sink { result in
                Task { @MainActor [weak self] in
                    guard let self else { return }
                    self.isPlaying = result
                }
            }
            .store(in: &cancellables)
    }
}
