//
//  MockLoginService.swift
//  GithubExplorerApp-TakeHomeProjectTests
//
//  Created by Ikmal Azman on 28/07/2022.
//

import Foundation
@testable import GithubExplorerApp_TakeHomeProject

class MockLoginService : LoginServiceContract {
    
    func requestLogin(_ user: String, page: Int, completion: @escaping (Result<[User], APIError>) -> Void) {
    }
}
