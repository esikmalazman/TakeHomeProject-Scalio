//
//  MockNavigationControllers.swift
//  GithubExplorerApp-TakeHomeProjectTests
//
//  Created by Ikmal Azman on 28/07/2022.
// https://stackoverflow.com/a/54419831/12528747

import UIKit

class MockNavigationControllers : UINavigationController {
    
    /// Allow to track and test if the vc had being pop
    var isBeingPopToRootViewController = false
    
    override func popViewController(animated: Bool) -> UIViewController? {
        isBeingPopToRootViewController = true
        return self.viewControllers.first
    }
}
