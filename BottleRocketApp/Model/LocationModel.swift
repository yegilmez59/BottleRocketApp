//
//  LocationModel.swift
//  BottleRocketApp
//
//  Created by Yagmur Egilmez on 8/9/21.
//

import Foundation

struct Location: Decodable {
    let address: String
    let crossStreet: String?
    let lat: Double
    let lng: Double
    let postalCode: String?
    let cc: String
    let city: String
    let state: String
    let country: String
    let formattedAddress: [String]
}

