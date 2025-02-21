//
//  SearchService.swift
//  RecommendLoLChams-Flab
//
//  Created by 김혜지 on 2/15/25.
//

struct SearchService: SearchSummonerUseCase {
    private let client: HTTPClient

    init(client: HTTPClient) {
        self.client = client
    }
    
    func getPuuid(gameName: String, tagLine: String) async throws -> String {
        let api = try GetPuuidAPI(gameName: gameName, tagLine: tagLine)
        let data = try await client.fetch(from: api)
        guard let dto = try? Mapper.map(from: data, to: PuuidDTO.self) else { throw HTTPError.invalidData }
        return dto.puuid
    }
    
    func searchSummoner(puuid: String) async throws -> Summoner {
        let api = try SearchSummonerAPI(puuid: puuid)
        let data = try await client.fetch(from: api)
        guard let dto = try? Mapper.map(from: data, to: SummonerDTO.self) else { throw HTTPError.invalidData }
        return dto.toModel()
    }
}
