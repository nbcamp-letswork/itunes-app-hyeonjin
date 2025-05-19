//
//  HomeViewModel.swift
//  iTunesAppHyeonjin
//
//  Created by 유현진 on 5/10/25.
//

import Foundation
import RxSwift
import RxRelay

final class HomeViewModel: ViewModelProtocol {
    enum Action {
        case fetchSeasonMusic
    }
    
    enum Mutation {
        case setSeasonMusic([HomeSectionItem])
    }
    
    struct State {
        var seasonMusic: [HomeSectionItem] = []
    }
    
    var state: BehaviorRelay<State>
    var action: PublishRelay<Action>
    var useCase: ItunesUseCaseProtocol
    var disposeBag: DisposeBag
    
    init(useCase: ItunesUseCaseProtocol) {
        state = BehaviorRelay(value: State())
        action = PublishRelay()
        disposeBag = DisposeBag()
        self.useCase = useCase
        bind()
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .fetchSeasonMusic:
            Observable.merge(
                useCase.fetchMusicBySeason(season: .spring).map { $0.map { .bestSpring($0) } },
                useCase.fetchMusicBySeason(season: .spring).map { $0.map { .spring($0) } },
                useCase.fetchMusicBySeason(season: .summer).map { $0.map { .summer($0) } },
                useCase.fetchMusicBySeason(season: .autumn).map { $0.map { .autumn($0) } },
                useCase.fetchMusicBySeason(season: .winter).map { $0.map { .winter($0) } }
            )
            .map { .setSeasonMusic($0) }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setSeasonMusic(let items):
            newState.seasonMusic += items
        }
        return newState
    }
}
