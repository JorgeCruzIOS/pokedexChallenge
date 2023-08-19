//
//  PkmDetailAPIService.swift
//  Pokedex
//
//  Created by Dsi Soporte Tecnico on 18/08/23.
//

import Foundation

class PkmDetailAPIService: APIService {
    
    let route : String

    init(route:String) {
        self.route = route
    }
    
    func fetchData<T: Decodable>(success: @escaping (Int, T) -> Void, failure: @escaping (Int, String) -> Void){
        DispatchQueue.global(qos: .utility).async {
            APIServicesManager.shareManager.getServices(route: self.route) { responseCode, responseData in
                guard let responseModel = APIServicesHelper.decode(JSONObject: responseData, entity: T.self) else{
                    failure(500,"Respuesta no valida")
                    return
                }
                success(responseCode, responseModel)
            } failure: { responseCode, responseMessage in
                failure(responseCode,responseMessage)
            }
        }
    }
    
}
