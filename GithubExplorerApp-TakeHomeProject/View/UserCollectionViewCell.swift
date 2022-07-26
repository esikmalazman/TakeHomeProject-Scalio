//
//  UserCollectionViewCell.swift
//  GithubExplorerApp-TakeHomeProject
//
//  Created by Ikmal Azman on 26/07/2022.
//

import UIKit

class UserCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static let identifier = "UserCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "\(self)", bundle: .main)
    }

}
