//
//  EvolutionChain.swift
//  Pokedex
//
//  Created by Edward Pizzurro on 3/24/25.
//

import Foundation

struct EvolutionChainResponse: Codable {
    let chain: EvolutionNode
}

struct EvolutionNode: Codable {
    let species: PokemonInfo
    let evolves_to: [EvolutionNode]
}
