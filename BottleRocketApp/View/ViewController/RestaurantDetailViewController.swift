//
//  RestaurantDetailViewController.swift
//  BottleRocketApp
//
//  Created by Yagmur Egilmez on 8/8/21.
//

import UIKit

class RestaurantDetailViewController: UIViewController {
    private lazy var restaurantMapView: RestaurantMapView = {
        let mapView = RestaurantMapView(latitudes: [self.restaurantDetailViewModel.latitude], longitudes: [self.restaurantDetailViewModel.longitude], titles: [self.restaurantDetailViewModel.formattedMapAnnotationTitle])
        mapView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        return mapView
    }()
    
    private lazy var basicInfoView: RestaurantBasicInfoView = {
        let infoView = RestaurantBasicInfoView(name: self.restaurantDetailViewModel.name, category: self.restaurantDetailViewModel.category)
        infoView.heightAnchor.constraint(equalToConstant: 72).isActive = true
        return infoView
    }()
    
    private lazy var contactInfoView: RestaurantContactInfoView = {
        let contactView = RestaurantContactInfoView(address: self.restaurantDetailViewModel.formattedAddress, phone: self.restaurantDetailViewModel.formattedTelephone, twitter: self.restaurantDetailViewModel.twitterHandle)
        return contactView
    }()
    
    init?(restaurantDetailViewModel: RestaurantDetailViewModel?) {
        guard let restVM = restaurantDetailViewModel else { return nil }
        self.restaurantDetailViewModel = restVM
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private let restaurantDetailViewModel: RestaurantDetailViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
    }
    
    private func setUpUI() {
        let stackView = UIStackView(axis: .vertical)
        stackView.addArrangedSubview(self.restaurantMapView)
        stackView.addArrangedSubview(self.basicInfoView)
        stackView.addArrangedSubview(self.contactInfoView)
        self.view.addSubview(stackView)
        stackView.boundToSuperView()
    }
}
