//
//  TestHelpers.swift
//  GithubExplorerApp-TakeHomeProjectTests
//
//  Created by Ikmal Azman on 27/07/2022.
//

import UIKit

//MARK: - UIButton

/// Helper method to execute action in UIButton
func tap(_ button : UIButton) {
    button.sendActions(for: .touchUpInside)
}

//MARK: - Utilities
/// Helper method to put vc into UIWindow
func putViewInWindow(_ vc : UIViewController) {
    let window = UIWindow()
    window.addSubview(vc.view)
}

/// Helper method to execute immediately events registered in UIKit
func executeRunLoop() {
    RunLoop.main.run(until: Date())
}

//MARK: - UITextfield Delegate
/// Helper method to execute return action from textfield delegate
@discardableResult
func shouldReturn(_ textfield : UITextField) -> Bool? {
    return textfield.delegate?.textFieldShouldReturn?(textfield)
}
