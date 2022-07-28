//
//  LoginService.swift
//  GithubExplorerApp-TakeHomeProject
//
//  Created by Ikmal Azman on 28/07/2022.
//

import Foundation

protocol LoginServiceContract {
    func requestLogin(_ user : String, page : Int, completion : @escaping (Result<[User], APIError>)->Void)
}

class LoginService : LoginServiceContract {
    
    var networkManager = NetworkManager()
    
    func requestLogin(_ user: String,
                      page: Int, completion: @escaping (Result<[User], APIError>) -> Void) {
        let endpoint = Endpoint.users(username: user, page: page).url
        networkManager.requestApi(from: endpoint, objectToDecode: UsersResponse.self) { result in
            switch result {
            case .success(let users):
                completion(.success(users.items ?? []))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
