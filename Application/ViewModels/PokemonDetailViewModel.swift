//
//  PokemonDetailViewModel.swift
//  Pokedex
//
//  Created by Edward Pizzurro on 3/23/25.
//

import Foundation

final class PokemonDetailViewModel {
    let pokemon: Pokemon
    private let evolutionService: EvolutionServiceProtocol

    var evolutionNames: [String] = []
    var onEvolutionLoaded: (() -> Void)?

    init(pokemon: Pokemon, evolutionService: EvolutionServiceProtocol = EvolutionService()) {
        self.pokemon = pokemon
        self.evolutionService = evolutionService
    }

    var name: String {
        pokemon.name.capitalized
    }

    var idText: String {
        "#\(pokemon.id)"
    }

    var imageURL: URL? {
        Endpoint.pokemonImage(id: pokemon.id).urlRequest?.url
    }

    var typesText: String {
        let types = pokemon.types.map { $0.type.name.capitalized }
        return types.joined(separator: ", ")
    }

    var movesText: String {
        let moveNames = pokemon.moves.prefix(3).map { $0.move.name.capitalized }
        return moveNames.joined(separator: ", ")
    }
    
    func loadEvolutions() {
        Task {
            do {
                let names = try await evolutionService.fetchEvolutionChain(for: pokemon.species.url)
                self.evolutionNames = names
                await MainActor.run {
                    self.onEvolutionLoaded?()
                }
            } catch {
                print("Error loading evolutions:", error)
            }
        }
    }
}
