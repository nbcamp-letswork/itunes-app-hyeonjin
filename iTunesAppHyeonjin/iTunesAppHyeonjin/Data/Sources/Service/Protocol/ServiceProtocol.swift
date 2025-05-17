//
//  ServiceProtocol.swift
//  iTunesAppHyeonjin
//
//  Created by 유현진 on 5/9/25.
//

import Foundation

protocol ServiceProtocol {
    func request<T: Decodable>(_ type: ServiceTypeProtocol) async throws -> T
}
