//
//  SearchUserViewModel.swift
//  GithubExplorerApp-TakeHomeProject
//
//  Created by Ikmal Azman on 27/07/2022.
//

import Foundation

protocol SearchViewModelDelegate : AnyObject {
    func showEmptyAlert(_ viewModel : SearchViewModel)
    func beginSearchUsername(_ viewModel : SearchViewModel, username :String)
}

class SearchViewModel {
    
    weak var delegate : SearchViewModelDelegate?
    
    func validateLoginField(_ username : String?) {
        guard let username = username,
              !username.isEmpty ,
              !username.trimmingCharacters(in: .whitespaces).isEmpty else {
            delegate?.showEmptyAlert(self)
            return
        }
        delegate?.beginSearchUsername(self, username: username)
    }
}
