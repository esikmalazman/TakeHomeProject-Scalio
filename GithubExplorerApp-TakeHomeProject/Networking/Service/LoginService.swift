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
    func requestLogin(_ user: String, page: Int, completion: @escaping (Result<[User], APIError>) -> Void) {
        <#code#>
    }
}
