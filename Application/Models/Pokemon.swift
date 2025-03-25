//
//  Pokemon.swift
//  Pokedex
//
//  Created by Edward Pizzurro on 3/23/25.
//

import Foundation

struct Pokemon: Decodable {
    let id: Int
    let name: String
    let types: [TypeSlot]
    let moves: [MoveSlot]
    let species: PokemonInfo
}

struct TypeSlot: Decodable {
    let type: PokemonInfo
}

struct MoveSlot: Decodable {
    let move: PokemonInfo
}
