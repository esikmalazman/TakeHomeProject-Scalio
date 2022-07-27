//
//  UserCollectionViewCell.swift
//  GithubExplorerApp-TakeHomeProject
//
//  Created by Ikmal Azman on 26/07/2022.
//

import UIKit

class UserCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var loginNameLabel: UILabel!
    @IBOutlet weak var userTypeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static let identifier = "UserCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "\(self)", bundle: .main)
    }

}
