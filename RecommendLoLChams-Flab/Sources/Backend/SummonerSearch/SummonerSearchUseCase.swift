//
//  SummonerSearchAPI.swift
//  RecommendLoLChams-Flab
//
//  Created by 김혜지 on 1/18/25.
//

import Foundation

struct SummonerSearchAPI: RequestAPI {
    typealias Parameter = EmptyParameter
    typealias Response = [SummonerDTO]
        
    let url: URL?
    let headers: [String: String]
    let httpMethod: HTTPMethod
    let parameter: EmptyParameter?
    
    init(name: String) {
        self.url = URL(string: "https://kr.api.riotgames.com/lol/summoner/v4/summoners/by-name/\(name)")
        self.headers = [:]
        self.httpMethod = .get
        self.parameter = nil
    }
}

protocol SummonerSearchUseCase {
    func searchSummoner(name: String) async throws -> [Summoner]
}

struct SummonerSearchService: SummonerSearchUseCase {
    private let client: HTTPClient

    init(client: HTTPClient) {
        self.client = client
    }

    func searchSummoner(name: String) async throws -> [Summoner] {
        let api = SummonerSearchAPI(name: name)
        let data = try await client.fetch(from: api)
        guard let summoners = try? Mapper.map(from: data, to: [SummonerDTO].self) else { throw HTTPError.invalidData }
        return summoners.toModel()
    }
}

struct MockSummonerSearchService: SummonerSearchUseCase {
    private let summoners: [Summoner] = [.init(puuid: "", name: "")]
    
    func searchSummoner(name: String) async throws -> [Summoner] {
        return summoners
    }
}

private extension Array where Element == SummonerDTO {
    func toModel() -> [Summoner] {
        return self.compactMap({ Summoner(puuid: $0.puuid, name: $0.puuid) })
    }
}
