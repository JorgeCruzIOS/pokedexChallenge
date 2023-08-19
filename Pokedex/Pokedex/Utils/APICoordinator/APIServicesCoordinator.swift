//
//  APIServicesCoordinator.swift
//  Pokedex
//
//  Created by Dsi Soporte Tecnico on 17/08/23.
//

import Foundation

protocol APIService {
    func fetchData<T:Decodable>( success: @escaping (_ responseCode: Int, _ response: T) -> Void,
                    failure: @escaping (_ responseCode: Int, _  responseMessage: String) -> Void)
}

protocol APIServiceImage{
    func fetchData(success: @escaping (Data) -> Void, failure: @escaping ( String) -> Void)
}

class APIServicesCoordinator {
    private var apiService: Any
    
    init(apiService: Any) {
        self.apiService = apiService
    }
    
    convenience init(apiServiceImage: Any) {
        self.init(apiService: apiServiceImage)
    }
    
    func performFetchData<T:Decodable>(
        success: @escaping (_ responseCode: Int, _ response: T) -> Void,
        failure: @escaping (_ responseCode: Int, _  responseMessage: String) -> Void){
            guard let apiService = apiService as? APIService else {
                failure(500,"API service does not support fetching")
                return
            }
            apiService.fetchData(success: success, failure: failure)
        }
    
    func performFetchImageData(success: @escaping (Data) -> Void, failure: @escaping (String) -> Void) {
        guard let imageService = apiService as? APIServiceImage else {
            failure("API service does not support image fetching")
            return
        }
        imageService.fetchData(success: success, failure: failure)
    }
    
}
