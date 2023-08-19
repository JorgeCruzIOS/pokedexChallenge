//
//  APIServicesBuilder.swift
//  Pokedex
//
//  Created by Dsi Soporte Tecnico on 17/08/23.
//

import UIKit
import Foundation

public enum HTTPMethod: String{
    case POST = "POST"
    case GET = "GET"
}

class APIServicesManager: NSObject {

    static var shareManager = APIServicesManager()
    
    private override init() {}
    
    func getServices(
        method  : HTTPMethod = .GET,
        route   : String,
        success: @escaping (_ responseCode: Int, _ response: Data) -> Void,
        failure: @escaping (_ responseCode: Int, _  responseMessage: String) -> Void)
    {
        let session = configurationRequest()
        guard let  url =  URL(string: route) else{
            return failure(500, "Recurso no encontrado")
        }
        let request = headerRequest(route: url, method: method)
        
        let task = session.dataTask(with: request) { data, response, error in
            if let response = response as? HTTPURLResponse, response.statusCode == 500 {
                failure(response.statusCode, "Error de servidor")
                return
            }
            guard let data = data, let response = response as? HTTPURLResponse else {
                failure((response as? HTTPURLResponse)?.statusCode ?? 500, error?.localizedDescription ?? "Error de servidor")
                return
            }
            success(response.statusCode, data)
        }
        task.resume()
    }
    
    func getImage(route:String,
                  success: @escaping (_ response: Data) -> Void,
                  failure: @escaping (_ responseMessage: String) -> Void){
        let session = configurationRequest()
        guard let  url =  URL(string: route) else{
            return failure("Recurso no encontrado")
        }
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                return failure("Recurso no encontrado")
            }
            success(data)
        }
        task.resume()
    }
    
}

extension APIServicesManager: URLSessionDelegate{
    
    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        let credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
        completionHandler(.useCredential, credential);
    }
    
    private func configurationRequest()->URLSession{
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 15.0
        sessionConfig.timeoutIntervalForResource = 10.0
        return URLSession(configuration: sessionConfig, delegate: self, delegateQueue:  nil)
    }
    
    private func headerRequest(route: URL,method:HTTPMethod)->URLRequest{
        var request: URLRequest = URLRequest(url: route)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = method.rawValue
        return request
    }
}
