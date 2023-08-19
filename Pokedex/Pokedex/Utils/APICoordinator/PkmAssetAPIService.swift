//
//  ImagePokemonAPIServices.swift
//  Pokedex
//
//  Created by Dsi Soporte Tecnico on 18/08/23.
//

import Foundation

class PkmAssetAPIService: APIServiceImage {
    private let numberPokemon: String
    let route = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/"

    init(withNumberPokemon:String) {
        self.numberPokemon = withNumberPokemon
    }
    
    func fetchData(success: @escaping (Data) -> Void, failure: @escaping ( String) -> Void){
        DispatchQueue.global(qos: .utility).async {
            let completationRoute = self.route +  "\(self.numberPokemon).png"
            APIServicesManager.shareManager.getImage(route: completationRoute) { response in
                success(response)
            } failure: { responseMessage in
                failure(responseMessage)
            }

        }
    }
    
}
