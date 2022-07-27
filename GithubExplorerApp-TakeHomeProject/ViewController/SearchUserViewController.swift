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
    
    var networkManager = NetworkManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        loginTextField.delegate = self
    }
    
}

//MARK: - Actions
extension SearchUserViewController {
    @IBAction private func didTapCancel(_ sender : UIButton) {
        loginTextField.text = ""
        loginTextField.resignFirstResponder()
        print("Cancel Tap")
    }
    
    @IBAction private func didTapSubmit(_ sender : UIButton) {
        guard let loginText = loginTextField.text, !loginText.isEmpty else {
            #warning("present alert to insert string")
            presentSimpleAlert(message: "Please enter words in Login",
                               buttonTitle: "OK") { [weak self] in
                self?.loginTextField.becomeFirstResponder()
            }
            return
        }
        
        let searchResultsVC = SearchResultsViewController(username: loginText)
        navigationController?.pushViewController(searchResultsVC, animated: true)
        
        networkManager.requestLogin(loginText) { users, error in
            
        }
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


#warning("""
TODO's
1. Setup data model ✅
2. Setup and basic configure network request ✅
3. Verify no empty spaces in textfield in order to proceed to search, check in submit button or textfield ✅
4. Add alert show if emtpy login (nice to have) ✅
5. Refactor to MVVM
""")

// https://stackoverflow.com/questions/24102641/how-to-check-if-a-text-field-is-empty-or-not-in-swift
