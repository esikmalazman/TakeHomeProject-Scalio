//
//  NetworkService.swift
//  GithubExplorerApp-TakeHomeProject
//
//  Created by Ikmal Azman on 27/07/2022.
//

import Foundation

enum Endpoint {
    case users(username : String, page : Int = 1, usersPerPage : Int = 9)
}

extension Endpoint {
    
    var url : URL {
        switch self {
        case .users(let username, let page, let resultsPerPage):
            return .createEndpoint("users?q=\(username)&page=\(page)&per_page=\(resultsPerPage)")
        }
    }
}

enum ApiURL : String {
    case baseURL
}

extension ApiURL {
    var url : URL {
        return URL(string: "https://api.github.com/search/")!
    }
}

enum APIError : String, Error {
    case invalidURL = "The requested URL is invalid, please try again"
    case unableToComplete = "Unable to complete the request, please check your internet connection"
    case invalidData = "The data received from server is invalid, please try again"
    case invalidResponse = "Invalid response from server"
}


