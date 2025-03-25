
import XCTest
import UIKit
@testable import Pokedex

final class PokemonTypeColorProviderTests: XCTestCase {
    func test_colorForKnownTypes() {
        XCTAssertEqual(PokemonTypeColorProvider.color(for: "fire"), UIColor.systemRed)
        XCTAssertEqual(PokemonTypeColorProvider.color(for: "WATER"), UIColor.systemBlue)
        XCTAssertEqual(PokemonTypeColorProvider.color(for: "Grass"), UIColor.systemGreen)
        XCTAssertEqual(PokemonTypeColorProvider.color(for: "electric"), UIColor.systemYellow)
        XCTAssertEqual(PokemonTypeColorProvider.color(for: "flying"), UIColor.systemBlue.withAlphaComponent(0.5))
    }

    func test_colorForUnknownType_returnsDefault() {
        let color = PokemonTypeColorProvider.color(for: "unknown-type")
        XCTAssertEqual(color, UIColor.systemGray5)
    }
}
