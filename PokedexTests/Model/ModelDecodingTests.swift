
import XCTest
@testable import Pokedex

final class ModelDecodingTests: XCTestCase {
    
    func test_pokemon_decodesCorrectly() throws {
        let json = """
        {
            "id": 1,
            "name": "bulbasaur",
            "types": [{ "type": { "name": "grass", "url": "some_url" } }],
            "moves": [{ "move": { "name": "tackle", "url": "some_url" } }],
            "species": { "name": "bulbasaur", "url": "some_species_url" }
        }
        """.data(using: .utf8)!

        let decoded = try JSONDecoder().decode(Pokemon.self, from: json)
        XCTAssertEqual(decoded.name, "bulbasaur")
        XCTAssertEqual(decoded.id, 1)
        XCTAssertEqual(decoded.types.first?.type.name, "grass")
        XCTAssertEqual(decoded.moves.first?.move.name, "tackle")
    }

    func test_pokemonSpecies_decodesCorrectly() throws {
        let json = """
        {
            "evolution_chain": {
                "url": "https://pokeapi.co/api/v2/evolution-chain/1/"
            }
        }
        """.data(using: .utf8)!

        let decoded = try JSONDecoder().decode(PokemonSpecies.self, from: json)
        XCTAssertEqual(decoded.evolution_chain.url, "https://pokeapi.co/api/v2/evolution-chain/1/")
    }

    func test_evolutionChain_decodesCorrectly() throws {
        let json = """
        {
            "chain": {
                "species": { "name": "bulbasaur", "url": "" },
                "evolves_to": [
                    {
                        "species": { "name": "ivysaur", "url": "" },
                        "evolves_to": [
                            {
                                "species": { "name": "venusaur", "url": "" },
                                "evolves_to": []
                            }
                        ]
                    }
                ]
            }
        }
        """.data(using: .utf8)!

        let decoded = try JSONDecoder().decode(EvolutionChainResponse.self, from: json)
        XCTAssertEqual(decoded.chain.species.name, "bulbasaur")
        XCTAssertEqual(decoded.chain.evolves_to.first?.species.name, "ivysaur")
        XCTAssertEqual(decoded.chain.evolves_to.first?.evolves_to.first?.species.name, "venusaur")
    }
}
