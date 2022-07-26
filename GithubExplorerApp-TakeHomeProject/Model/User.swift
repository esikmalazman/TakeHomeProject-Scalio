//
//  User.swift
//  GithubExplorerApp-TakeHomeProject
//
//  Created by Ikmal Azman on 26/07/2022.
//

import Foundation

struct UsersResponse : Decodable {
    let items : [User]?
}

struct User : Decodable {
    let login : String?
    let avatar_url : String?
    let type : String?
}
