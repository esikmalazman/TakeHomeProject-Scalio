//
//  MockLoginService.swift
//  GithubExplorerApp-TakeHomeProjectTests
//
//  Created by Ikmal Azman on 28/07/2022.
//

import Foundation
@testable import GithubExplorerApp_TakeHomeProject

class MockLoginService : LoginServiceContract {
    
    var requestLoginArguementsUser = [String]()
    var requestLoginArguementsPage = [Int]()
    var requestLoginCompletionUser = [User]()

    var apiErrorType : APIError = APIError.invalidData
    var successMakeRequest = false
    var requestLoginCallCount = 0
    
    func requestLogin(_ user: String,
                      page: Int,
                      completion: @escaping (Result<[User], APIError>) -> Void) {
        requestLoginCallCount = requestLoginCallCount + 1
        requestLoginArguementsUser.append(user)
        requestLoginArguementsPage.append(page)
        
        if successMakeRequest {
            let response = [
                User(login: "Abu", avatar_url: "https:/dummy1.com", type: "User"),
                User(login: "Brandon", avatar_url: "https:/dummy2.com", type: "User"),
                User(login: "FakeCompany", avatar_url: "https:/dummy2.com", type: "Organization")
            ]
            
            completion(.success(response))
        } else {
            completion(.failure(apiErrorType))
        }
    }
}


#warning("can be scale for network request test")
