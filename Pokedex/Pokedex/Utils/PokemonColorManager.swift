//
//  PokemonColorManager.swift
//  Pokedex
//
//  Created by Dsi Soporte Tecnico on 18/08/23.
//

import Foundation

enum ColorByTypo: String {
    case Grass = "grass"
    case Poison = "poison"
    case Fire = "fire"
    case Water = "water"
    case Bug = "bug"
    case Dark = "dark"
    case Fairy = "fairy"
    case Normal = "normal"
    case Fight = "fighting"
    case Ghost = "ghost"
    case Eletric = "electric"
    case Steel = "steel"
    case Rock = "rock"
    case Ground = "ground"
    case Dragon = "dragon"
    case Psychic  = "psychic"
    case Ice = "ice"
    case Fly = "flying"
    
    func fetchColor()->UIColor{
        switch self{
            case .Grass:
                return UIColor(rgb: 0x9CCC65)
            case .Poison:
                return UIColor(rgb: 0xAB47BC)
            case .Fire:
                return UIColor(rgb: 0xFFA726)
            case .Water:
                return UIColor(rgb: 0x42A5F5)
            case .Bug:
                return UIColor(rgb: 0xD4E157)
            case .Dark:
                return UIColor(rgb: 0x424242)
            case .Fairy:
                return UIColor(rgb: 0xF8BBD0)
            case .Normal:
                return UIColor(rgb: 0xEEEEEE)
            case .Fight:
                return UIColor(rgb: 0xEF5350)
            case .Ghost:
                return UIColor(rgb: 0x7E57C2)
            case .Eletric:
                return UIColor(rgb: 0xFFEE58)
            case .Steel:
                return UIColor(rgb: 0x795548)
            case .Rock:
                return UIColor(rgb: 0x8D6E63)
            case .Ground:
                return UIColor(rgb: 0xD2691E)
            case .Dragon:
                return UIColor(rgb: 0x5C6BC0)
            case .Psychic:
                return UIColor(rgb: 0xEC407A)
            case .Ice:
                return UIColor(rgb: 0x26C6DA)
            case .Fly:
                return UIColor(rgb: 0xE3F2FD)
        }
    }
    
    func fetchColorText()->UIColor{
        switch self{
            case .Grass,.Bug,.Fairy,.Normal,.Eletric,.Psychic,.Ice,.Fly:
                return .black
            case .Poison,.Fire,.Dark,.Fight,.Ghost,.Steel,.Rock,.Dragon,.Water,.Ground:
                return .white
        }
    }
}
