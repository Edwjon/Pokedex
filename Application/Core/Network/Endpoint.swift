//
//  Endpoint.swift
//  Pokedex
//
//  Created by Edward Pizzurro on 3/23/25.
//

import Foundation

enum Endpoint {
    case pokemonList(limit: Int)
    case pokemonDetail(id: Int)
    case pokemonImage(id: Int)
    case pokemonSpecies(url: String)
    case evolutionChain(url: String)

    var urlRequest: URLRequest? {
        switch self {
        case .pokemonList(let limit):
            return makeRequest("https://pokeapi.co/api/v2/pokemon?limit=\(limit)")
        case .pokemonDetail(let id):
            return makeRequest("https://pokeapi.co/api/v2/pokemon/\(id)")
        case .pokemonImage(let id):
            return makeRequest("https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png")
        case .pokemonSpecies(let urlString),
             .evolutionChain(let urlString):
            return makeRequest(urlString)
        }
    }

    private func makeRequest(_ urlString: String) -> URLRequest? {
        guard let url = URL(string: urlString) else { return nil }
        return URLRequest(url: url, timeoutInterval: 15)
    }
}
