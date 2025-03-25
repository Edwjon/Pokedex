//
//  PokemonTypeColorProvider.swift
//  Pokedex
//
//  Created by Edward Pizzurro on 3/24/25.
//

import Foundation
import UIKit

enum PokemonTypeColorProvider {
    static func color(for type: String) -> UIColor {
        switch type.lowercased() {
        case "fire": return UIColor.systemRed
        case "water": return UIColor.systemBlue
        case "grass": return UIColor.systemGreen
        case "electric": return UIColor.systemYellow
        case "bug": return UIColor.systemTeal
        case "poison": return UIColor.systemPurple
        case "psychic": return UIColor.systemPink
        case "normal": return UIColor.systemGray
        case "ground": return UIColor.brown
        case "rock": return UIColor.darkGray
        case "fairy": return UIColor.systemPink.withAlphaComponent(0.6)
        case "fighting": return UIColor.systemOrange
        case "ghost": return UIColor.systemIndigo
        case "dragon": return UIColor(red: 0.5, green: 0.3, blue: 0.8, alpha: 1)
        case "ice": return UIColor.cyan
        case "dark": return UIColor.black
        case "steel": return UIColor.gray
        case "flying": return UIColor.systemBlue.withAlphaComponent(0.5)
        default: return UIColor.systemGray5
        }
    }
}
