//
//  Pokemon.swift
//  Pokedex
//
//  Created by Edward Pizzurro on 3/23/25.
//

import Foundation

struct Pokemon: Codable {
    let id: Int
    let name: String
    let types: [TypeSlot]
    let moves: [MoveSlot]
    let species: PokemonInfo
}

struct TypeSlot: Codable {
    let type: PokemonInfo
}

struct MoveSlot: Codable {
    let move: PokemonInfo
}
