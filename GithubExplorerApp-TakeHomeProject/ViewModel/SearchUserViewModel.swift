//
//  SearchUserViewModel.swift
//  GithubExplorerApp-TakeHomeProject
//
//  Created by Ikmal Azman on 27/07/2022.
//

import Foundation

protocol SearchUserViewModelDelegate : AnyObject {
    func showEmptyAlert(_ viewModel : SearchUserViewModel)
    func beginSearchUsername(_ viewModel : SearchUserViewModel, username :String)
}

class SearchUserViewModel {
    
    var delegate : SearchUserViewModelDelegate?
    
    func validateLoginField(_ username : String?) {
        guard let username = username, !username.isEmpty else {
            delegate?.showEmptyAlert(self)
            return
        }
        delegate?.beginSearchUsername(self, username: username)
    }
}
