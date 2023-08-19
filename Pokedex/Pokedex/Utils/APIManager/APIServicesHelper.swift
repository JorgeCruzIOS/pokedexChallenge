//
//  APIServicesHelper.swift
//  Pokedex
//
//  Created by Dsi Soporte Tecnico on 17/08/23.
//

import Foundation
class APIServicesHelper{
    
    static func decode<T:Decodable> (JSONObject: Data, entity : T.Type) -> (T?) {
        let objectdecoded   = try? JSONDecoder().decode(T.self, from: JSONObject)
        return objectdecoded
    }
}
