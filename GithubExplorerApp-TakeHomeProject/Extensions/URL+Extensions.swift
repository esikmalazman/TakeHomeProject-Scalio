//
//  URL+Extensions.swift
//  GithubExplorerApp-TakeHomeProject
//
//  Created by Ikmal Azman on 27/07/2022.
//

import Foundation

extension URL {
    /// Helper method to create endpoint from base url
    static func createEndpoint(_ endpoint : String) -> URL {
        let urlString = "https://api.github.com/search/\(endpoint)"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        return URL(string: urlString ?? "")!
    }
}
