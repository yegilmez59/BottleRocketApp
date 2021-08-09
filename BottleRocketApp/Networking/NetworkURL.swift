//
//  NetworkURL.swift
//  BottleRocketApp
//
//  Created by Yagmur Egilmez on 8/8/21.
//

import Foundation

enum NetworkURLs: String {
    
    case webPage = "https://www.bottlerocketstudios.com"
    case lunchdata = "https://s3.amazonaws.com/br-codingexams/restaurants.json"
    
    var url: URL? {
        return URL(string: self.rawValue)
    }
}
