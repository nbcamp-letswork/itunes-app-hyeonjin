//
//  ServiceType.swift
//  iTunesAppHyeonjin
//
//  Created by 유현진 on 5/9/25.
//

import Foundation

enum ServiceType {
    case fetchMusicBySeason(season: String)
}

extension ServiceType: ServiceTypeProtocol {
    var baseURL: String {
        return "https://itunes.apple.com/"
    }
    
    var path: String {
        switch self {
        case .fetchMusicBySeason:
            return "search?"
        }
    }
    
    var parameter: [String: Any]? {
        switch self {
        case .fetchMusicBySeason(let season):
            return ["term" : season, "country" : "KR", "media" : "music"]
        }
    }
}
