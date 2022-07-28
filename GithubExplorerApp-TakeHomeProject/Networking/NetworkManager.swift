//
//  NetworkManager.swift
//  GithubExplorerApp-TakeHomeProject
//
//  Created by Ikmal Azman on 26/07/2022.
//

import Foundation

protocol URLSessionContract {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession : URLSessionContract {}

class NetworkManager {
    
    var session : URLSessionContract = URLSession.shared
    
    func requestApi<T:Decodable>(from url : URL, objectToDecode object : T.Type, completion : @escaping (Result<T,APIError>)->Void) {
        
        let task = session.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedObject = try decoder.decode(object.self, from: data)
                completion(.success(decodedObject))
                
            } catch {
                completion(.failure(.invalidData))
                fatalError("Error : \(String(describing: error))")
            }
        }
        task.resume()
    }
}
