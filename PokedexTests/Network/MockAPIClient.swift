
import Foundation
@testable import Pokedex

final class MockAPIClient: APIClientProtocol {
    var responses: [String: Data] = [:]
    var mockError: Error?

    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        if let error = mockError {
            throw error
        }

        guard let url = endpoint.urlRequest?.url?.absoluteString,
              let data = responses[url] else {
            throw NetworkError.invalidResponse
        }

        return try JSONDecoder().decode(T.self, from: data)
    }

    func requestRawData(_ endpoint: Endpoint) async throws -> Data {
        guard let url = endpoint.urlRequest?.url?.absoluteString,
              let data = responses[url] else {
            throw NetworkError.invalidResponse
        }
        return data
    }
}
