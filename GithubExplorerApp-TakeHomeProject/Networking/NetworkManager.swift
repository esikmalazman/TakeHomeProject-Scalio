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
    
    func requestLogin(_ user : String, page : Int, completion : @escaping (Result<[User], Error>)->Void) {
#warning("take care of query that have spaces")
        let endpoint = Endpoint.users(username: user, page: page).url
        
        print("Endpoint : \(endpoint)")
        
        requestApi(from: endpoint, objectToDecode: UsersResponse.self) { result in
            switch result {
                
            case .success(let users):
                completion(.success(users.items ?? []))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func requestApi<T:Decodable>(from url : URL, objectToDecode object : T.Type, completion : @escaping (Result<T,Error>)->Void) {
        
        let task = session.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedObject = try decoder.decode(object.self, from: data)
                completion(.success(decodedObject))
                
            } catch {
                completion(.failure(error))
                fatalError("Error : \(String(describing: error))")
            }
            
        }
        
        task.resume()
    }
}


#warning("""
TODO's
1. Make generic network request ✅
2. Utilise URLComponents to refactor api path✅
3. Add pagination ✅
""")
