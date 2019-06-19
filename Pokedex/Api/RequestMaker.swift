//
//  PokeApi.swift
//  Pokedex
//
//  Created by Marielle Wronka on 08/06/2019.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import Foundation


enum RequestMakerError: Error {
    case malFormedURL
    case requestFailed
    case invalidData
    case decodingFailed
}

class RequestMaker {
    
    static let decoder = JSONDecoder()
    
    let baseUrl = "http://localhost:3000/"
    let session = URLSession.shared
    typealias RequestResult<T> = Result<T, RequestMakerError>
    typealias CompletionCallback<T: Decodable> = (RequestResult<T>) -> Void
    typealias SuccessCallback<T: Decodable> = (T) -> Void
    
    
    func make<T: Decodable>(withEndpoint endpoint: Endpoint, completion: @escaping SuccessCallback<T>) {
        
        make(withEndpoint: endpoint) { (result: RequestResult<T>) in
            switch result {
            case .success(let object):
                completion(object)
            case .failure:
                break
            }
        }
    }
    
    private func make<T: Decodable>(withEndpoint endpoint: Endpoint,
                            completion: @escaping CompletionCallback<T>) {
        
        guard let url = URL(string: "\(baseUrl)\(endpoint.url)") else {
            completion(.failure(.malFormedURL))
            return
        }
        
        let dataTask = session.dataTask(with: url) {
            (data: Data?, response: URLResponse?, error: Error?) in
            
            guard error == nil else {
                completion(.failure(.requestFailed))
                print(error!)
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                print("não veio")
                return
            }
            
            do {
                let decodeObject = try RequestMaker.decoder.decode(T.self, from: data)
                completion(RequestResult.success(decodeObject))
            } catch let error {
                completion(.failure(.decodingFailed))
                print("Error: " + error.localizedDescription)
            }
        }
        
        dataTask.resume()
    }
}
