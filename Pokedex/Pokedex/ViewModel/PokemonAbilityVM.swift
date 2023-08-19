//
//  PokemonAbilityVM.swift
//  Pokedex
//
//  Created by Dsi Soporte Tecnico on 18/08/23.
//

import Foundation

class PokemonAbilityVM{
    private (set) var pkmEffect: NSMutableAttributedString?
    
    init(efect: EffectPK, ability: String) {
        self.pkmEffect = ability.capitalized.decorative(color: .black, font: .systemFont(ofSize: 18, weight: .semibold)).apply(new: "\n\(efect.effect)".decorative(color: .black, font: .systemFont(ofSize: 16, weight: .light)))
    }
}
