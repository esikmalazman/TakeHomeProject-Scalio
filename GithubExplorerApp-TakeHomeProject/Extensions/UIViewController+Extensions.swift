//
//  UIViewController+Extensions.swift
//  GithubExplorerApp-TakeHomeProject
//
//  Created by Ikmal Azman on 27/07/2022.
//

import UIKit

extension UIViewController {
    func createSimpleAlert(_ title : String = "",
                            message : String?,
                            actions : [UIAlertAction]) -> UIAlertController {
        
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        
        actions.forEach { action in
            alertController.addAction(action)
        }
        
//        DispatchQueue.main.async { [weak self] in
//            self?.present(alertController, animated: true)
//        }
        
        return alertController
    }
}
