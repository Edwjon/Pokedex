
import XCTest
@testable import Pokedex

final class EvolutionServiceTests: XCTestCase {
    func test_fetchEvolutionChain_success() async throws {
        let mockClient = MockAPIClient()
        
        let speciesURL = "https://pokeapi.co/api/v2/pokemon-species/1/"
        let chainURL = "https://pokeapi.co/api/v2/evolution-chain/1/"

        let species = PokemonSpecies(
            evolution_chain: EvolutionChainLink(url: chainURL)
        )
        let evolutionResponse = EvolutionChainResponse(chain: EvolutionNode(
            species: PokemonInfo(name: "bulbasaur", url: ""),
            evolves_to: [
                EvolutionNode(species: PokemonInfo(name: "ivysaur", url: ""), evolves_to: [
                    EvolutionNode(species: PokemonInfo(name: "venusaur", url: ""), evolves_to: [])
                ])
            ])
        )

        mockClient.responses[speciesURL] = try JSONEncoder().encode(species)
        mockClient.responses[chainURL] = try JSONEncoder().encode(evolutionResponse)

        let service = EvolutionService(apiClient: mockClient)
        let result = try await service.fetchEvolutionChain(for: speciesURL)

        XCTAssertEqual(result, ["Bulbasaur", "Ivysaur", "Venusaur"])
    }
}
