//
//  PokemonListViewModel.swift
//  Pokedex
//
//  Created by Edward Pizzurro on 3/23/25.
//


import Foundation

final class PokemonListViewModel {
    private let pokemonService: PokemonServiceProtocol
    private(set) var pokemons: [Pokemon] = []
    private(set) var filteredPokemons: [Pokemon] = []

    var onDataUpdated: (() -> Void)?
    var onError: ((Error) -> Void)?

    init(pokemonService: PokemonServiceProtocol = PokemonService()) {
        self.pokemonService = pokemonService
    }

    func fetchPokemons() {
        Task {
            do {
                let result = try await pokemonService.fetchAllPokemons()
                self.pokemons = result
                self.filteredPokemons = result
                await MainActor.run {
                    self.onDataUpdated?()
                }
            } catch {
                await MainActor.run {
                    self.onError?(error)
                }
            }
        }
    }

    func numberOfItems() -> Int {
        filteredPokemons.count
    }

    func pokemon(at index: Int) -> Pokemon {
        filteredPokemons[index]
    }

    func filterPokemons(with query: String) {
        if query.isEmpty {
            filteredPokemons = pokemons
        } else {
            filteredPokemons = pokemons.filter {
                $0.name.lowercased().contains(query.lowercased())
            }
        }
        onDataUpdated?()
    }
}
