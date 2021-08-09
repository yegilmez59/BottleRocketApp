//
//  RestaurantModel.swift
//  BottleRocketApp
//
//  Created by Yagmur Egilmez on 8/8/21.
//

import Foundation

struct RestaurantWrapper: Decodable {
    let restaurants: [Restaurant]
}

struct Restaurant: Decodable {
    let name: String
    let backgroundImageURL: String
    let category: String
    let contact: Contact?
    let location: Location
}
