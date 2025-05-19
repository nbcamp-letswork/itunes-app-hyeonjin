//
//  DIContainer.swift
//  iTunesAppHyeonjin
//
//  Created by 유현진 on 5/14/25.
//

import Foundation

final class DIContainer {
    func makeHomeViewModel() -> HomeViewModel {
        let repository = ItunesRepository(service: NetworkService())
        let useCase = ItunesUseCase(repository: repository)
        return HomeViewModel(useCase: useCase)
    }
}
