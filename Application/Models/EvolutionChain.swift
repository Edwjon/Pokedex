//
//  EvolutionChain.swift
//  Pokedex
//
//  Created by Edward Pizzurro on 3/24/25.
//

import Foundation

struct EvolutionChainResponse: Decodable {
    let chain: EvolutionNode
}

struct EvolutionNode: Decodable {
    let species: PokemonInfo
    let evolves_to: [EvolutionNode]
}
