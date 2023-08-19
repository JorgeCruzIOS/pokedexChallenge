//
//  PokemonDetailModel.swift
//  Pokedex
//
//  Created by Dsi Soporte Tecnico on 18/08/23.
//

import Foundation

struct PokemonDetailModel: Codable{
    let name: String
    let order: Int
    let height: Int
    let weight: Int
    let base_experience: Int
    let types: [TypesPK]?
    let abilities: [AbilitiesPK]?
}

struct AbilitiesPK: Codable{
    let ability: AbilityPK
}

struct AbilityPK: Codable{
    let name: String
    let url: String
}


struct TypesPK: Codable{
    let type: TypePK
}

struct TypePK: Codable{
    let name: String
    let url: String
}
