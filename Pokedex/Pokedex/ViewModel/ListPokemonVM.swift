//
//  ListPokemonViewModel.swift
//  Pokedex
//
//  Created by Dsi Soporte Tecnico on 18/08/23.
//

import Foundation
 
class ListPokemonVM: NSObject{
    
    typealias Response = HeaderModel<PokemonModel>
    private var pokemonList = [PokemonVM]()
    private var pokemonCoordinator : APIServicesCoordinator
    
    @objc override init() {
        self.pokemonCoordinator = APIServicesCoordinator(apiService: PkmListAPIService())
    }
    
    @objc func loadListPokemon(_ succesfull: @escaping ()-> Void){
        pokemonCoordinator.performFetchData { [weak self] (responseCode, response: Response) in
            self?.pokemonList = response.results?.compactMap({ pk in
                return PokemonVM(pokemonModel: pk)
            }) ?? []
            succesfull()
        } failure: { responseCode, response in
            
        }
    }
    
    @objc func numberOfRowsInSection()->Int{
        return self.pokemonList.count
    }
    
    @objc func pokemonAtRow(_ index: Int)->PokemonVM{
        return self.pokemonList[index]
    }
    
    @objc func fetchToPDF()->[PokemonVM]{
        return Array(self.pokemonList.prefix(10))
    }
}
