//
//  ItunesRepository.swift
//  iTunesAppHyeonjin
//
//  Created by 유현진 on 5/10/25.
//

import Foundation
import RxSwift

final class ItunesRepository: ItunesRepositoryProtocol {
    let service: NetworkService
    
    init(service: NetworkService) {
        self.service = service
    }
    
    func fetchMusicBySeason(season: Season) -> Single<[Track]> {
        Single.create { [weak self] emitter in
            guard let self else { return Disposables.create() }
            Task {
                do {
                    let response: SearchDTO = try await self.service.request(ServiceType.fetchMusicBySeason(season: season.rawValue))
                    emitter(.success(response.results.map { $0.toEntity() }))
                } catch {
                    emitter(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
}
