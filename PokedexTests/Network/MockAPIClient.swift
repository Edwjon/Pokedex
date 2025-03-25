
import Foundation
@testable import Pokedex

final class MockAPIClient: APIClientProtocol {
    var mockData: Data?
    var mockError: Error?

    func request<T>(_ endpoint: Endpoint) async throws -> T where T : Decodable {
        if let error = mockError {
            throw error
        }
        guard let data = mockData else {
            throw NetworkError.invalidResponse
        }
        return try JSONDecoder().decode(T.self, from: data)
    }

    func requestRawData(_ endpoint: Endpoint) async throws -> Data {
        if let error = mockError {
            throw error
        }
        guard let data = mockData else {
            throw NetworkError.invalidResponse
        }
        return data
    }
}
