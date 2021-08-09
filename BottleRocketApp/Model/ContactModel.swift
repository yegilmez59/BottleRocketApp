//
//  ContactModel.swift
//  BottleRocketApp
//
//  Created by Yagmur Egilmez on 8/9/21.
//

import Foundation

struct Contact: Decodable {
    let phone: String
    let formattedPhone: String
    let twitter: String?
}
