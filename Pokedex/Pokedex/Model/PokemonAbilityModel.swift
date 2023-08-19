//
//  PokemonTypesModel.swift
//  Pokedex
//
//  Created by Dsi Soporte Tecnico on 18/08/23.
//

import Foundation

struct PokemonAbilityModel: Codable{
    let effect_entries: [EffectPK]?
    let name: String
}

struct EffectPK: Codable{
    let effect: String
    let language: LanguagePK?
}

struct LanguagePK: Codable{
    let name : String
    let url: String
}
