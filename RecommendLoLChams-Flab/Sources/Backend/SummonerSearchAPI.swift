//
//  SummonerSearchAPI.swift
//  RecommendLoLChams-Flab
//
//  Created by 김혜지 on 1/18/25.
//

import Foundation

enum HTTPError: Error {
    case invalidURL
    case invalidData
}

protocol SummonerSearchAPI {
    func searchUser(id: String) async throws -> [Summoner]
}

struct SummonerSearchService: SummonerSearchAPI {
    private let client: HTTPClient

    init(client: HTTPClient) {
        self.client = client
    }

    func searchUser(id: String) async throws -> [Summoner] {
        guard let url = URL(string: "https://kr.api.riotgames.com/lol/summoner/v4/summoners/by-name/\(id)") else { throw HTTPError.invalidURL }
        let data = try await client.fetch(from: url)
        guard let summoners = map(data: data, to: [SummonerDTO].self) else { throw HTTPError.invalidData }
        return summoners.toModel()
    }

    // 매퍼 분리
    private func map<T: Decodable>(data: Data, to model: T.Type) -> T? {
        let decoder = JSONDecoder()
        return try? decoder.decode(model, from: data)
    }
}

private extension Array where Element == SummonerDTO {
    func toModel() -> [Summoner] {
        return self.compactMap({ Summoner(puuid: $0.puuid, name: $0.puuid) })
    }
}
