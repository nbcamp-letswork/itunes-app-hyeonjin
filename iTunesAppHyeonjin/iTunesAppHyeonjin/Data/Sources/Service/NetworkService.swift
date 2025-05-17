//
//  NetworkService.swift
//  iTunesAppHyeonjin
//
//  Created by 유현진 on 5/9/25.
//

import Foundation

enum NetworkError: Error {
    case invaildURL
    case statusCodeError
    case decodingError
}

final class NetworkService: ServiceProtocol {
    func request<T: Decodable>(_ type: ServiceTypeProtocol) async throws -> T where T: Decodable {
        var urlComponent = URLComponents(string: type.baseURL + type.path)
        
        urlComponent?.queryItems = type.parameter?.compactMap {
            return URLQueryItem(name: $0.key, value: "\($0.value)")
        }
        
        guard let url = urlComponent?.url else {
            throw NetworkError.invaildURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
            throw NetworkError.statusCodeError
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError
        }
    }
}
