
import XCTest
@testable import Pokedex
import UIKit

final class PokemonViewControllerTests: XCTestCase {

    func test_PokemonCell_configuresProperly() {
        let frame = CGRect(x: 0, y: 0, width: 120, height: 160)
        let cell = PokemonCell(frame: frame)
        let pokemon = Pokemon(
            id: 1,
            name: "bulbasaur",
            types: [TypeSlot(type: PokemonInfo(name: "grass", url: ""))],
            moves: [],
            species: PokemonInfo(name: "bulbasaur", url: "")
        )
        cell.configure(with: pokemon)
        XCTAssertEqual(cell.subviews.count > 0, true)
    }

    func test_PokemonDetailViewController_loadsView() {
        let pokemon = Pokemon(
            id: 4,
            name: "charmander",
            types: [TypeSlot(type: PokemonInfo(name: "fire", url: ""))],
            moves: [MoveSlot(move: PokemonInfo(name: "ember", url: ""))],
            species: PokemonInfo(name: "charmander", url: "some_url")
        )
        let viewModel = PokemonDetailViewModel(pokemon: pokemon, evolutionService: MockEvolutionService2())
        let vc = PokemonDetailViewController(viewModel: viewModel)
        vc.loadViewIfNeeded()
        XCTAssertEqual(vc.title, "Charmander")
    }

    func test_PokemonListViewController_setsTitle() {
        let vc = PokemonListViewController()
        vc.loadViewIfNeeded()
        XCTAssertEqual(vc.title, "Pokedex")
    }
}

// Mock reutilizado
final class MockEvolutionService2: EvolutionServiceProtocol {
    func fetchEvolutionChain(for speciesURL: String) async throws -> [String] {
        return ["Charmander", "Charmeleon", "Charizard"]
    }
}
