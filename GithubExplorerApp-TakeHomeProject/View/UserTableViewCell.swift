//
//  UserTableViewCell.swift
//  GithubExplorerApp-TakeHomeProject
//
//  Created by Ikmal Azman on 27/07/2022.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet private(set) weak var userImageView: UIImageView!
    @IBOutlet private(set) weak var usernameLabel: UILabel!
    @IBOutlet private(set) weak var userTypeLabel: UILabel!
    @IBOutlet private(set) weak var repositoryNameLabel: UILabel!
    @IBOutlet private(set) weak var repositoryLinkLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let margins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        contentView.frame = contentView.frame.inset(by: margins)
    }
    
    static let identifier = "UserTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "\(self)", bundle: .main)
    }
    
    func configure(cell data : User) {
        usernameLabel.text = data.login
        userTypeLabel.text = data.type
        userImageView.downloadImage(fromURLString: data.avatar_url ?? "")
        #warning("add configure for repo name and link too")
    }
}
