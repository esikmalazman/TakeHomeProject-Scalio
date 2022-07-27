//
//  SearchUserViewController.swift
//  GithubExplorerApp-TakeHomeProject
//
//  Created by Ikmal Azman on 26/07/2022.
//

import UIKit

class SearchUserViewController: UIViewController {
    
    @IBOutlet private(set) weak var cancelButton: UIButton!
    @IBOutlet private(set) weak var loginTextField: UITextField!
    @IBOutlet private(set) weak var submitButton: UIButton!
    @IBOutlet private(set) weak var introImageView: UIImageView!
    
    let viewModel = SearchUserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
}

//MARK: - Actions
extension SearchUserViewController {
    @IBAction private func didTapCancel(_ sender : UIButton) {
        loginTextField.text = ""
        loginTextField.resignFirstResponder()
    }
    
    @IBAction private func didTapSubmit(_ sender : UIButton) {
        viewModel.validateLoginField(loginTextField.text)
    }
}

//MARK: - UITextFieldDelegate
// - Add method to prevent empty words in textfield, show popup
extension SearchUserViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginTextField {
            didTapSubmit(submitButton)
            return true
        }
        return false
    }
}

//MARK: - SearchUserViewModelDelegate
extension SearchUserViewController : SearchUserViewModelDelegate {
    func showEmptyAlert(_ viewModel: SearchUserViewModel) {
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.loginTextField.becomeFirstResponder()
        }
        
        presentSimpleAlert(message: "Please enter words in Login",
                           actions: [okAction])
    }
    
    func beginSearchUsername(_ viewModel: SearchUserViewModel, username: String) {
        let searchResultsVC = SearchResultsViewController(username: username)
        navigationController?.pushViewController(searchResultsVC, animated: true)
    }
}


private extension SearchUserViewController {
    func configureViewController() {
        loginTextField.delegate = self
        viewModel.delegate = self
        
        submitButton.layer.cornerRadius = 8
        navigationController?.navigationBar
            .largeTitleTextAttributes = [.foregroundColor: AppTheme.primaryGreen]
    }
}
