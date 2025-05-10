//
//  ItunesRepository.swift
//  iTunesAppHyeonjin
//
//  Created by 유현진 on 5/10/25.
//

import Foundation

final class ItunesRepository: ItunesRepositoryProtocol {
    let service: NetworkService
    
    init(service: NetworkService) {
        self.service = service
    }
    
    func fetchMusicBySeason(season: Season) async throws -> [Track] {
        let response: SearchDTO = try await service.request(ServiceType.fetchMusicBySeason(season: season.rawValue))
        return response.results.map { $0.toEntity() }
    }
}
