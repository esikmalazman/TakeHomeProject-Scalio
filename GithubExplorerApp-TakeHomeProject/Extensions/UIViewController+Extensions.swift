//
//  UIViewController+Extensions.swift
//  GithubExplorerApp-TakeHomeProject
//
//  Created by Ikmal Azman on 27/07/2022.
//

import UIKit

extension UIViewController {
    
    func presentSimpleAlert(_ title : String = "",
                            message : String?,
                            buttonTitle : String,
                            completion : @escaping ()->Void) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let buttonAction = UIAlertAction(title: buttonTitle,
                                         style: .default) { action in
            completion()
        }
        alertController.addAction(buttonAction)
        
        DispatchQueue.main.async { [weak self] in
            self?.present(alertController, animated: true)
        }
    }
}
