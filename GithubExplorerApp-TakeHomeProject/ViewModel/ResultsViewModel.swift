//
//  SearchResultViewModel.swift
//  GithubExplorerApp-TakeHomeProject
//
//  Created by Ikmal Azman on 27/07/2022.
//

import Foundation

protocol ResultsViewModelDelegate : AnyObject {
    func didReceiveUsers()
    func showFailureAlert(_ message : String)
}

class ResultsViewModel {
    
    var networkManager = NetworkManager()
    
    weak var delegate : ResultsViewModelDelegate?
    
    var page = 1
    var listOfUser = [User]() {
        didSet {
            listOfUser.sort { firstUser, secondUser in
                firstUser.login! < secondUser.login!
            }
        }
    }
    
    func requestUsers(_ user : String) {
        networkManager.requestLogin(user, page: page) { [weak self] result in
            switch result {
                
            case .success(let users):
                users.forEach { user in
                    self?.listOfUser.append(user)
                }
                self?.delegate?.didReceiveUsers()
                
            case .failure(let error):
                self?.delegate?.showFailureAlert(error.rawValue)
            }
        }
    }
    
    func nextPageUser(_ user : String) {
        page = page + 1
        requestUsers(user)
    }
    
    func resetListOfUsers() {
        page = 1
        listOfUser = []
    }
}

extension ResultsViewModel {
    func totalNumberOfUsers() -> String {
        return "\(listOfUser.count) Results found"
    }
}
