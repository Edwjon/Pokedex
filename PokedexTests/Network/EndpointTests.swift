
import XCTest
@testable import Pokedex

final class EndpointTests: XCTestCase {
    func test_pokemonListEndpoint() {
        let endpoint = Endpoint.pokemonList(limit: 151)
        XCTAssertEqual(endpoint.urlRequest?.url?.absoluteString, "https://pokeapi.co/api/v2/pokemon?limit=151")
    }

    func test_pokemonDetailEndpoint() {
        let endpoint = Endpoint.pokemonDetail(id: 25)
        XCTAssertEqual(endpoint.urlRequest?.url?.absoluteString, "https://pokeapi.co/api/v2/pokemon/25")
    }

    func test_pokemonImageEndpoint() {
        let endpoint = Endpoint.pokemonImage(id: 7)
        XCTAssertEqual(endpoint.urlRequest?.url?.absoluteString, "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/7.png")
    }

    func test_pokemonSpeciesEndpoint() {
        let url = "https://pokeapi.co/api/v2/pokemon-species/1/"
        let endpoint = Endpoint.pokemonSpecies(url: url)
        XCTAssertEqual(endpoint.urlRequest?.url?.absoluteString, url)
    }

    func test_evolutionChainEndpoint() {
        let url = "https://pokeapi.co/api/v2/evolution-chain/1/"
        let endpoint = Endpoint.evolutionChain(url: url)
        XCTAssertEqual(endpoint.urlRequest?.url?.absoluteString, url)
    }
}
