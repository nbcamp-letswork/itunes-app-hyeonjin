//
//  ItunesRepositoryProtocol.swift
//  iTunesAppHyeonjin
//
//  Created by 유현진 on 5/10/25.
//

import Foundation

protocol ItunesRepositoryProtocol {
    func fetchMusicBySeason(season: Season) async throws -> [Track]
}
