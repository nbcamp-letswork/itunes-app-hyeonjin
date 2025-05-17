//
//  ViewModelProtocol.swift
//  iTunesAppHyeonjin
//
//  Created by 유현진 on 5/14/25.
//

import Foundation
import RxSwift
import RxRelay

protocol ViewModelProtocol: AnyObject {
    associatedtype Action
    associatedtype Mutation
    associatedtype State

    var state: BehaviorRelay<State> { get }
    var action: PublishRelay<Action> { get }

    var disposeBag: DisposeBag { get }

    func mutate(action: Action) -> Observable<Mutation>
    func reduce(state: State, mutation: Mutation) -> State
    func bind()
}

extension ViewModelProtocol {
    func bind() {
        action
            .flatMap { [weak self] action -> Observable<Mutation> in
                guard let self else { return .empty() }
                return mutate(action: action)
            }
            .subscribe { [weak self] mutation in
                guard let self else { return }
                let newState = reduce(state: state.value, mutation: mutation)
                state.accept(newState)
            }
            .disposed(by: disposeBag)
    }
}
