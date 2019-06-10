//
//  PokeApi.swift
//  Pokedex
//
//  Created by Marielle Wronka on 08/06/2019.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import Foundation

class RequestMaker {
    
    enum Endpoint {
        case list
        case details(query: String)
        case move
        
        var url: String {
            switch self {
            case .list:
                return "list"
            case let .details(query):
                return "details/\(query)"
            case .move:
                return "moves"
            }
        }
        
        var modelTyoe: Decodable.Type {
            switch self {
            case .list:
                return PokemonList.self
            case .details:
                return Pokemon.self
            case .move:
                return MoveList.self
            }
        }
    }
    
    let baseUrl = "http://localhost:3000/"
    let session = URLSession.shared
    typealias CompletionCallback<T: Decodable> = (T) -> Void
    
    func make<T: Decodable>(withEndpoint endpoint: Endpoint, completion: @escaping CompletionCallback<T>) {
        guard let url = URL(string: "\(baseUrl)\(endpoint.url)") else {
            return
        }
        
        let dataTask = session.dataTask(with: url) {
            (data: Data?, response: URLResponse?, error: Error?) in
            
            guard error == nil else {
                print(error!)
                return
            }
            
            guard let data = data else {
                print("não veio")
                return
            }
            
            do {
                let decodeObject = try JSONDecoder().decode(T.self, from: data)
                completion(decodeObject)
            } catch let error {
                print("Error: " + error.localizedDescription)
            }
        }
        
        dataTask.resume()
    }
}
