//
//  PokemonSpecies.swift
//  Pokedex
//
//  Created by Edward Pizzurro on 3/24/25.
//

import Foundation

struct PokemonSpecies: Codable {
    let evolution_chain: EvolutionChainLink
}

struct EvolutionChainLink: Codable {
    let url: String
}
