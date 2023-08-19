//
//  PokemonDetail.swift
//  Pokedex
//
//  Created by Dsi Soporte Tecnico on 18/08/23.
//

import Foundation

class PokemonDetailVM{
    private (set) var pkmNameNumber: NSMutableAttributedString
    private (set) var pkmImage: Data
    private (set) var pkmBaseExp: NSMutableAttributedString?
    private (set) var pkmBackground: UIColor?
    private (set) var pkmHeight: NSMutableAttributedString?
    private (set) var pkmWeight: NSMutableAttributedString?
    private (set) var pkmTypo = [ColorByTypo]()
    private (set) var pkmAbilities = [PokemonAbilityVM]()
    
    init(pokemonVM: PokemonVM){
        pkmNameNumber = pokemonVM.pkmName?.appending(" \n").decorative(color: .black, font: .systemFont(ofSize: 26, weight: .bold)).apply(
            new: pokemonVM.pkmNumber?.decorative(color: .darkGray, font: .systemFont(ofSize: 16, weight: .semibold)) ?? NSMutableAttributedString()) ?? NSMutableAttributedString()
        pkmImage = pokemonVM.pkmImage ?? Data()
    }
    
    func applyExtraInformation(pokemonDetailModel: PokemonDetailModel){
        pkmBaseExp = "\(pokemonDetailModel.base_experience ) \n".decorative(color: .black, font: .systemFont(ofSize: 26, weight: .bold)).apply(
                new: "Base experience".decorative(color: .darkGray, font: .systemFont(ofSize: 16)))
        pkmBackground = ColorByTypo(rawValue: pokemonDetailModel.types?.first?.type.name ?? "fire")?.fetchColor()
        pokemonDetailModel.types?.forEach({ typo in
            pkmTypo.append(ColorByTypo(rawValue: typo.type.name) ?? .Fire)
        })
        let fixedHeight = String(format: "%.1f", Double(pokemonDetailModel.height) * 0.1)
        let fixedWeight = String(format: "%.1f", Double(pokemonDetailModel.weight) * 0.1)
        pkmWeight = "\(fixedWeight) kg \n".decorative(color: .black, font: .systemFont(ofSize: 20, weight: .bold)).apply(
            new: "Weight".decorative(color: .gray, font: .systemFont(ofSize: 14, weight: .light)))
        pkmHeight = "\(fixedHeight) m \n".decorative(color: .black, font: .systemFont(ofSize: 20, weight: .bold)).apply(
            new: "Height".decorative(color: .gray, font: .systemFont(ofSize: 14, weight: .light)))
    }
    
    func applyAbilitiesInformation(abilities: PokemonAbilityModel){
        if let ability = (abilities.effect_entries?.filter({ effect in
            return effect.language?.name == "en"
        }) ?? []).first{
            pkmAbilities.append(PokemonAbilityVM(efect: ability, ability: abilities.name))
        }
    }
}
