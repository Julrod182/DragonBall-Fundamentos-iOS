//
//  NetworkModel.swift
//  DragonBallApp-JDRR
//
//  Created by Julio Rodriguez Reategui on 12/07/22.
//

import Foundation

enum NetworkError: Error {
    case malformedURL
    case dataFormating
    case otherError
    case noData
    case errorCode(Int?)
    case tokenFormatError
    case decoding
}


class NetworkModel {
    
    var token: String? //Variable that stores the user's token
    
    // static let shared = NetworkModel()
    
    // private init() {}
    
    init(token: String? = nil){
        self.token = token
    }
    
    //Func that prints the user token and stores the token on a variable
    
    func login(user: String, password: String, completion: @escaping (String?, NetworkError?) -> Void) {
        guard let url = URL(string: "https://vapor2022.herokuapp.com/api/auth/login") else {
            completion(nil, NetworkError.malformedURL)
            return
        }
        
        let loginString = user + ":" + password
        guard let loginData = loginString.data(using: .utf8) else {
            completion(nil, NetworkError.dataFormating)
            return
        }
        
        let base64LoginString = loginData.base64EncodedString()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                completion(nil, NetworkError.otherError)
                return
            }
            
            guard let data = data else {
                completion(nil, NetworkError.noData)
                return
            }
            
            guard let httpResponse = (response as? HTTPURLResponse),
                  httpResponse.statusCode == 200 else{
                completion(nil, NetworkError.errorCode((response as? HTTPURLResponse)?.statusCode))
                return
            }
            
            guard let token = String(data: data, encoding: .utf8) else {
                completion(nil, NetworkError.tokenFormatError)
                return
            }
            //self.token = token
            
            completion(token,nil)
        }
        task.resume()
    }
    
    func getHeroes(name: String = "", completion: @escaping ([Hero], NetworkError?) -> Void){
        guard let url = URL(string: "https://vapor2022.herokuapp.com/api/heros/all") else {
            completion([], NetworkError.malformedURL)
            return
        }
        
        guard let token = self.token else {
            completion([], .otherError)
            return
        }

        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        struct Body: Encodable {
            let name: String
        }
        
        let body = Body(name: name)
        
        urlRequest.httpBody = try? JSONEncoder().encode(body)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                completion([], NetworkError.otherError)
                return
            }
            
            guard let data = data else {
                completion([], NetworkError.noData)
                return
            }
            
            guard let httpResponse = (response as? HTTPURLResponse),
                  httpResponse.statusCode == 200 else{
                completion([], NetworkError.errorCode((response as? HTTPURLResponse)?.statusCode))
                return
            }
            
            guard let heroesResponse = try? JSONDecoder().decode([Hero].self, from: data) else {
                completion([], NetworkError.decoding)
                return
            }
            
            completion(heroesResponse,nil)
        }
        task.resume()
    }
    
    //Agregar función getTransformations??? o solo modificar getHeroes
    
    //"D13A40E5-4418-4223-9CE6-D2F9A28EBE94"
    
    func getTransformations(id: String, completion: @escaping ([Transformation], NetworkError?) -> Void){
        guard let url = URL(string: "https://vapor2022.herokuapp.com/api/heros/tranformations") else {
            completion([], NetworkError.malformedURL)
            return
        }
        
        guard let token = self.token else {
            completion([], .otherError)
            return
        }

        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        struct Body: Encodable {
            let id: String
        }
        
        let body = Body(id: id)
        
        urlRequest.httpBody = try? JSONEncoder().encode(body)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                completion([], NetworkError.otherError)
                return
            }
            
            guard let data = data else {
                completion([], NetworkError.noData)
                return
            }
            
            guard let httpResponse = (response as? HTTPURLResponse),
                  httpResponse.statusCode == 200 else{
                completion([], NetworkError.errorCode((response as? HTTPURLResponse)?.statusCode))
                return
            }
            
            guard let transformationsResponse = try? JSONDecoder().decode([Transformation].self, from: data) else {
                completion([], NetworkError.decoding)
                return
            }
            completion(transformationsResponse.sorted { $0.name.compare($1.name, options: .numeric) == .orderedAscending }, nil)
        }
        task.resume()
    }
    
}
