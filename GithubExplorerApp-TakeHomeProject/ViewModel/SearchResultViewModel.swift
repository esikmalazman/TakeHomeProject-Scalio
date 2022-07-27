//
//  SearchResultViewModel.swift
//  GithubExplorerApp-TakeHomeProject
//
//  Created by Ikmal Azman on 27/07/2022.
//

import Foundation

protocol SearchViewModelDelegate : AnyObject {
    func didReceiveUsers()
}
class SearchResultViewModel {

    var networkManager = NetworkManager()
    
    var delegate : SearchViewModelDelegate?
    var listOfUser = [User]()
    var page = 1
    
    
    func requestUsers(_ user : String) {
        networkManager.requestLogin(user) { users, error in
            users?.forEach { user in
                self.listOfUser.append(user)
            }
            self.delegate?.didReceiveUsers()
        }
    }

    func nextPageUser(_ user : String) {
        page = page + 1
        requestUsers(user)
    }
}
