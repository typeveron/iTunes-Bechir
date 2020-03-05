//
//  URL.swift
//  iTunesB
//
//  Created by Bechir Mihoub on 2020-02-24.
//  Copyright © 2020 Bechir Mihoub. All rights reserved.
//

import Foundation


    
 extension URL {
     func withQueries(_ queries: [String: String]) -> URL? {
         var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
         components?.queryItems = queries.compactMap { URLQueryItem(name: $0.0, value: $0.1) }
         return components?.url
     }
 

 func withHTTPS() -> URL? {
        var components = URLComponents(url: self,
                                       resolvingAgainstBaseURL: true)
        components?.scheme = "https"
        return components?.url
    }
}

