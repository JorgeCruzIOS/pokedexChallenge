//
//  HeaderResponse.swift
//  Pokedex
//
//  Created by Dsi Soporte Tecnico on 17/08/23.
//

import Foundation

struct HeaderModel<T:Codable>: Codable{
    let count: Int
    let next: String?
    let previous: String?
    let results: [T]?
}
