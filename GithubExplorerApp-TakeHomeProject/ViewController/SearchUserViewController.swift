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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginTextField.delegate = self
    }
    
}

//MARK: - Actions
extension SearchUserViewController {
    @IBAction private func didTapCancel(_ sender : UIButton) {
        print("Cancel Tap")
    }
    
    @IBAction private func didTapSubmit(_ sender : UIButton) {
        print("Submit Tap")
    }
}

//MARK: - UITextFieldDelegate
extension SearchUserViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginTextField {
            // Navigate to results vc
            print("Push to NextVC")
        }
        return true
    }
}
