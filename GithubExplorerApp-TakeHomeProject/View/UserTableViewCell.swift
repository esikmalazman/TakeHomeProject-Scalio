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
    @IBOutlet private(set) weak var userTypeLabel: UIButton!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupContentView()
        setupUserTypeLabel()
        setupRoundedUserImage()
    }
    
    static let identifier = "UserTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "\(self)", bundle: .main)
    }
    
    func configure(cell data : User) {
        usernameLabel.text = data.login
        userTypeLabel.titleLabel?.text = data.type
        userImageView.downloadImage(fromURLString: data.avatar_url ?? "")
    }
}

private extension UserTableViewCell {
    func setupContentView() {
        let margins = UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15)
        contentView.frame = contentView.frame.inset(by: margins)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
    }
    
    func setupUserTypeLabel() {
        userTypeLabel.layer.cornerRadius = 8
    }
    
    func setupRoundedUserImage() {
        userImageView.layer.cornerRadius = userImageView.frame.height / 2
        userImageView.clipsToBounds = true
    }
}
