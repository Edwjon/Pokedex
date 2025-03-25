//
//  PokemonService.swift
//  Pokedex
//
//  Created by Edward Pizzurro on 3/23/25.
//

import Foundation

protocol PokemonServiceProtocol {
    func fetchAllPokemons() async throws -> [Pokemon]
    func fetchPokemonImage(id: Int) async throws -> Data
}

final class PokemonService: PokemonServiceProtocol {
    private let apiClient: APIClientProtocol

    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }

    func fetchAllPokemons() async throws -> [Pokemon] {
        let pokemonIDs = Array(1...151)

        var results = [Pokemon]()
        results.reserveCapacity(151)

        try await withThrowingTaskGroup(of: (Int, Pokemon).self) { group in
            for id in pokemonIDs {
                group.addTask {
                    async let pokemon: Pokemon = self.apiClient.request(.pokemonDetail(id: id))
                    return (id, try await pokemon)
                }
            }

            for try await (_, pokemon) in group {
                results.append(pokemon)
            }
        }

        return results.sorted(by: { $0.id < $1.id })
    }

    func fetchPokemonImage(id: Int) async throws -> Data {
        return try await apiClient.requestRawData(.pokemonImage(id: id))
    }
}
