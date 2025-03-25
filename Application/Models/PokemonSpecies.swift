//
//  PokemonSpecies.swift
//  Pokedex
//
//  Created by Edward Pizzurro on 3/24/25.
//

import Foundation

struct PokemonSpecies: Decodable {
    let evolution_chain: EvolutionChainLink
}

struct EvolutionChainLink: Decodable {
    let url: String
}
