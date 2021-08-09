//
//  NetworkError.swift
//  BottleRocketApp
//
//  Created by Yagmur Egilmez on 8/8/21.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case badData
    case decodeFailure
    case badStatusCode(Int)
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .badURL:
            return NSLocalizedString("Bad URL", comment: "Bad URL")
        case .badData:
            return NSLocalizedString("Bad Data", comment: "Bad Data")
        case .decodeFailure:
            return NSLocalizedString("Decode Failure", comment: "Decode Failure")
        case .badStatusCode(let code):
            return NSLocalizedString("The network connection was improper. Received Status code \(code)", comment: "Bad Status Code")
        }
    }
}
