//
//  ItunesUseCase.swift
//  iTunesAppHyeonjin
//
//  Created by 유현진 on 5/10/25.
//

import Foundation
import RxSwift

final class ItunesUseCase: ItunesUseCaseProtocol {
    let repository: ItunesRepositoryProtocol
    
    init(repository: ItunesRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchMusicBySeason(season: Season) async throws -> Observable<[Track]> {
        try await .just(repository.fetchMusicBySeason(season: season))
    }
}
