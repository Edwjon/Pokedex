
import XCTest
@testable import Pokedex

final class APIClientTests: XCTestCase {
//    var apiClient: APIClient!
//    var mockSession: URLSession!
//
//    override func setUp() {
//        super.setUp()
//        apiClient = APIClient()
//    }
//
//    func test_request_successfulDecoding() async throws {
//        let mockClient = MockAPIClient()
//        let expected = Pokemon(id: 1, name: "bulbasaur", types: [], moves: [], species: PokemonInfo(name: "bulbasaur", url: ""))
//        mockClient.mockData = try! JSONEncoder().encode(expected)
//
//        let result: Pokemon = try await mockClient.request(.pokemonDetail(id: 1))
//
//        XCTAssertEqual(result.id, expected.id)
//        XCTAssertEqual(result.name, expected.name)
//    }
//
//    func test_request_invalidURL() async {
//        let mockClient = APIClient()
//        let endpoint = Endpoint.pokemonSpecies(url: "invalid url")
//
//        do {
//            let _: PokemonSpecies = try await mockClient.request(endpoint)
//            XCTFail("Should have thrown")
//        } catch {
//            XCTAssertTrue(error.localizedDescription.contains("unsupported URL"))
//        }
//    }
//
//    func test_requestRawData_success() async throws {
//        let mockClient = MockAPIClient()
//        let expectedData = "test".data(using: .utf8)!
//        mockClient.mockData = expectedData
//
//        let data = try await mockClient.requestRawData(.pokemonImage(id: 1))
//        XCTAssertEqual(data, expectedData)
//    }
//
//    func test_requestRawData_failure() async {
//        let mockClient = MockAPIClient()
//        mockClient.mockError = NetworkError.invalidResponse
//
//        do {
//            let _ = try await mockClient.requestRawData(.pokemonImage(id: 1))
//            XCTFail("Should have thrown error")
//        } catch let error as NetworkError {
//            XCTAssertEqual(error, .invalidResponse)
//        } catch {
//            XCTFail("Unexpected error type: \(error)")
//        }
//    }
}
