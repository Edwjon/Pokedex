//
//  EvolutionService.swift
//  Pokedex
//
//  Created by Edward Pizzurro on 3/24/25.
//

import Foundation

protocol EvolutionServiceProtocol {
    func fetchEvolutionChain(for speciesURL: String) async throws -> [String]
}

final class EvolutionService: EvolutionServiceProtocol {
    private let apiClient: APIClientProtocol

    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }

    func fetchEvolutionChain(for speciesURL: String) async throws -> [String] {
        let species: PokemonSpecies = try await apiClient.request(.pokemonSpecies(url: speciesURL))

        let evolutionChain: EvolutionChainResponse = try await apiClient.request(.evolutionChain(url: species.evolution_chain.url))

        return parseEvolutionNames(from: evolutionChain.chain)
    }

    private func parseEvolutionNames(from node: EvolutionNode) -> [String] {
        var names = [node.species.name.capitalized]
        for evolution in node.evolves_to {
            names += parseEvolutionNames(from: evolution)
        }
        return names
    }
}

