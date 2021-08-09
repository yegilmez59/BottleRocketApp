//
//  RestaurantDetailsViewModel.swift
//  BottleRocketApp
//
//  Created by Yagmur Egilmez on 8/8/21.
//

import Foundation

class RestaurantDetailViewModel {
    
    internal let model: Restaurant
    private let service: NetworkService
    
    init(restaurant: Restaurant, service: NetworkService) {
        self.model = restaurant
        self.service = service
    }
    
    var name: String {
        return self.model.name
    }
        
    var category: String {
        return self.model.category
    }
        
    var formattedAddress: String {
        let charArrayAddress = self.model.location.formattedAddress.flatMap{
            "\($0)\n"
        }.dropLast()
        return String(charArrayAddress)
    }
        
    var formattedTelephone: String {
        return self.model.contact?.formattedPhone ?? "Phone Unavailable"
    }
    
    var twitterHandle: String {
        guard let tHandle = self.model.contact?.twitter else { return "Twitter Unavailable" }
        return "@\(tHandle)"
    }
    
    var latitude: Double {
        return self.model.location.lat
    }
    
    var longitude: Double {
        return self.model.location.lng
    }
    
    var formattedMapAnnotationTitle: String {
        return "\(self.model.name)\n\(self.model.location.city), \(self.model.location.state)"
    }
    
    func imageData(completion: @escaping (Data?) -> Void) {
        if let imageData = ImageCache.shared.getImageData(for: self.model.backgroundImageURL) {
            completion(imageData)
            return
        }
        
        self.service.fetchRawData(url: URL(string: self.model.backgroundImageURL)) { [weak self] (result) in
            switch result {
            case .success(let data):
                ImageCache.shared.setImageData(for: self?.model.backgroundImageURL, imageData: data)
                completion(data)
            case .failure(let err):
                print(err)
                completion(nil)
            }
        }
    }

}

