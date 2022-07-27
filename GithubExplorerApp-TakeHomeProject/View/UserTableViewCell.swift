//
//  UserTableViewCell.swift
//  GithubExplorerApp-TakeHomeProject
//
//  Created by Ikmal Azman on 27/07/2022.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userTypeLabel: UILabel!
    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var repositoryLinkLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static let identifier = "UserTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "\(self)", bundle: .main)
    }
}
