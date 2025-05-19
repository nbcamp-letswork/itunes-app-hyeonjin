//
//  ItunesUseCaseProtocol.swift
//  iTunesAppHyeonjin
//
//  Created by 유현진 on 5/10/25.
//

import Foundation
import RxSwift

protocol ItunesUseCaseProtocol {
    func fetchMusicBySeason(season: Season) -> Observable<[Track]>
}
