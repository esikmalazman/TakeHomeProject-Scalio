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
    
    func requestLogin(_ user : String) {
        guard let url = URL(string: "https://api.github.com/search/users?q=\(user)&page=1&per_page=9") else {
            return
        }
        
        print(url)
        session.dataTask(with: url) { data, response, error in
            
            if let error = error {
                fatalError(" Error : \(String(describing: error))")
                return
            }
            
            guard let data = data else {
                fatalError("Invalid Data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let object =  try decoder.decode(UsersResponse.self, from: data)
                dump(object)
            } catch {
                fatalError("Error : \(String(describing: error))")
            }
            
        }.resume()
    }
}

#warning("""
TODO's
1. Make generic network request
2. Utilise URLComponents to refactor api path
3. Add pagination
""")
