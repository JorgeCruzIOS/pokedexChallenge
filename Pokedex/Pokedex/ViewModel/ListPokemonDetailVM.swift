//
//  PokemonDetailVM.swift
//  Pokedex
//
//  Created by Dsi Soporte Tecnico on 18/08/23.
//

import Foundation

class ListPokemonDetailVM{
    
    private var pokemonCoordinator : APIServicesCoordinator
    private var pomemonDetailVM: PokemonDetailVM
    typealias ResponseDetail = PokemonDetailModel
    typealias ResponseAbility = PokemonAbilityModel
    let dispatchGroup = DispatchGroup()
    let downloadAbilities = DispatchQueue.global()
    
    init(pokemonVM: PokemonVM) {
        pomemonDetailVM = PokemonDetailVM(pokemonVM: pokemonVM)
        self.pokemonCoordinator = APIServicesCoordinator(apiService: PkmDetailAPIService(route: pokemonVM.urlDetail ?? ""))
    }
    
    func loadListPokemon(_ succesfull: @escaping ()-> Void){
        self.pokemonCoordinator.performFetchData { [weak self]  (responseCode, responseDetail:ResponseDetail) in
            self?.pomemonDetailVM.applyExtraInformation(pokemonDetailModel: responseDetail)
            responseDetail.abilities?.forEach({ abilitiesPK in
                self?.dispatchGroup.enter()
                self?.downloadAbilities.async {
                    self?.pokemonCoordinator = APIServicesCoordinator(apiService: PkmDetailAPIService(route: abilitiesPK.ability.url))
                    self?.pokemonCoordinator.performFetchData(success: { (responseCode, response:ResponseAbility) in
                        self?.pomemonDetailVM.applyAbilitiesInformation(abilities: response)
                        self?.dispatchGroup.leave()
                    }, failure: { responseCode, responseMessage in
                        self?.dispatchGroup.leave()
                    })
                }
            })
            self?.dispatchGroup.notify(queue: .main) {
                succesfull()
            }
        } failure: { responseCode, responseMessage in
            
        }
    }
    
    func fetchPokemonDetailVM()->PokemonDetailVM?{
        return pomemonDetailVM
    }
}
