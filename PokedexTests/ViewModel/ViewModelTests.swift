
import XCTest
@testable import Pokedex

final class PokemonViewModelTests: XCTestCase {

    func test_PokemonDetailViewModel_properties() {
        let mockPokemon = Pokemon(
            id: 25,
            name: "pikachu",
            types: [TypeSlot(type: PokemonInfo(name: "electric", url: ""))],
            moves: [
                MoveSlot(move: PokemonInfo(name: "thunderbolt", url: "")),
                MoveSlot(move: PokemonInfo(name: "quick-attack", url: "")),
                MoveSlot(move: PokemonInfo(name: "iron-tail", url: "")),
                MoveSlot(move: PokemonInfo(name: "electro-ball", url: ""))
            ],
            species: PokemonInfo(name: "pikachu", url: "species-url")
        )

        let viewModel = PokemonDetailViewModel(pokemon: mockPokemon, evolutionService: MockEvolutionService())

        XCTAssertEqual(viewModel.name, "Pikachu")
        XCTAssertEqual(viewModel.idText, "#25")
        XCTAssertEqual(viewModel.typesText, "Electric")
        XCTAssertEqual(viewModel.movesText, "Thunderbolt, Quick-Attack, Iron-Tail")
        XCTAssertNotNil(viewModel.imageURL)
    }

    func test_PokemonDetailViewModel_loadEvolutions_success() async {
        let expectation = expectation(description: "onEvolutionLoaded called")
        let mockPokemon = Pokemon(
            id: 1,
            name: "bulbasaur",
            types: [],
            moves: [],
            species: PokemonInfo(name: "bulbasaur", url: "url")
        )
        let mockService = MockEvolutionService()
        let viewModel = PokemonDetailViewModel(pokemon: mockPokemon, evolutionService: mockService)
        viewModel.onEvolutionLoaded = {
            expectation.fulfill()
        }

        viewModel.loadEvolutions()
        await fulfillment(of: [expectation], timeout: 1.0)
        XCTAssertEqual(viewModel.evolutionNames, ["Bulbasaur", "Ivysaur", "Venusaur"])
    }

    func test_PokemonListViewModel_fetch_success() async {
        let expectation = expectation(description: "onDataUpdated called")
        let mockPokemon = Pokemon(id: 1, name: "bulbasaur", types: [], moves: [], species: PokemonInfo(name: "", url: ""))
        let service = MockPokemonService(pokemons: [mockPokemon])
        let viewModel = PokemonListViewModel(pokemonService: service)
        viewModel.onDataUpdated = {
            expectation.fulfill()
        }

        viewModel.fetchPokemons()
        await fulfillment(of: [expectation], timeout: 1.0)
        XCTAssertEqual(viewModel.pokemons.count, 1)
    }
}

final class MockEvolutionService: EvolutionServiceProtocol {
    func fetchEvolutionChain(for speciesURL: String) async throws -> [String] {
        return ["Bulbasaur", "Ivysaur", "Venusaur"]
    }
}

final class MockPokemonService: PokemonServiceProtocol {
    func fetchPokemonImage(id: Int) async throws -> Data {
        return Data()
    }
    
    let result: [Pokemon]

    init(pokemons: [Pokemon]) {
        self.result = pokemons
    }

    func fetchAllPokemons() async throws -> [Pokemon] {
        return result
    }
}
