//
//  PokemonViewModel.swift
//  Pokedex
//
//  Created by Dsi Soporte Tecnico on 18/08/23.
//

import Foundation

class PokemonVM: NSObject{
    @objc private (set) var pkmName: String?
    @objc private (set) var pkmNumber: String?
    @objc private (set) var pkmImage: Data?
    @objc private (set) var urlDetail: String?
    private var pokemonCoordinator : APIServicesCoordinator
    
    init(pokemonModel:PokemonModel) {
        
        let number =  String(pokemonModel.url.replacingOccurrences(of: "v2", with: "").filter { $0.isNumber })
        self.pokemonCoordinator = APIServicesCoordinator(apiService: PkmAssetAPIService(withNumberPokemon: number))
        self.pkmName = pokemonModel.name.capitalized
        self.urlDetail = pokemonModel.url
        self.pkmNumber = "Nº \(number)"
    }
    
    @objc func fetchImage(_ succesfull: @escaping ()-> Void){
        guard let _ = pkmImage else{
            self.pokemonCoordinator.performFetchImageData { [weak self] img in
                self?.pkmImage = img
                succesfull()
            } failure: { message in
                succesfull()
            }
            return
        }
        succesfull()
    }
}
