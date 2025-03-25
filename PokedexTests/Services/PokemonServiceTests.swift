
import XCTest
@testable import Pokedex

final class PokemonServiceTests: XCTestCase {
    func test_fetchAllPokemons_success() async throws {
        let mockClient = MockAPIClient()
        let expected = Pokemon(id: 1, name: "bulbasaur", types: [], moves: [], species: PokemonInfo(name: "bulbasaur", url: ""))
        let encoded = try JSONEncoder().encode(expected)

        for id in 1...151 {
            let url = Endpoint.pokemonDetail(id: id).urlRequest!.url!.absoluteString
            mockClient.responses[url] = encoded
        }

        let service = PokemonService(apiClient: mockClient)
        let result = try await service.fetchAllPokemons()

        XCTAssertEqual(result.count, 151)
        XCTAssertEqual(result.first?.id, 1)
    }

    func test_fetchPokemonImage_success() async throws {
        let mockClient = MockAPIClient()
        let expectedData = "image".data(using: .utf8)!
        let url = Endpoint.pokemonImage(id: 7).urlRequest!.url!.absoluteString
        mockClient.responses[url] = expectedData

        let service = PokemonService(apiClient: mockClient)
        let result = try await service.fetchPokemonImage(id: 7)

        XCTAssertEqual(result, expectedData)
    }
}
