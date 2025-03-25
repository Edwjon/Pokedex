//
//  APIClient.swift
//  Pokedex
//
//  Created by Edward Pizzurro on 3/23/25.
//

import Foundation

protocol APIClientProtocol {
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T
    func requestRawData(_ endpoint: Endpoint) async throws -> Data
}

final class APIClient: APIClientProtocol {
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        guard let urlRequest = endpoint.urlRequest else {
            throw NetworkError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        try validateResponse(response)

        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingFailed(error)
        }
    }

    func requestRawData(_ endpoint: Endpoint) async throws -> Data {
        guard let urlRequest = endpoint.urlRequest else {
            throw NetworkError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        try validateResponse(response)
        return data
    }

    private func validateResponse(_ response: URLResponse?) throws {
        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw NetworkError.invalidResponse
        }
    }
}
