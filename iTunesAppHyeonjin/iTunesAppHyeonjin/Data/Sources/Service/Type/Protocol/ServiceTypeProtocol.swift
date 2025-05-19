//
//  ServiceTypeProtocol.swift
//  iTunesAppHyeonjin
//
//  Created by 유현진 on 5/9/25.
//

import Foundation

protocol ServiceTypeProtocol {
    var baseURL: String { get }
    var path: String { get }
    var parameter: [String: Any]? { get }
}
