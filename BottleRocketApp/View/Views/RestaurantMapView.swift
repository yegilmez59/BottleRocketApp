//
//  RestaurantMapView.swift
//  BottleRocketApp
//
//  Created by Yagmur Egilmez on 8/8/21.
//


import UIKit
import MapKit

class RestaurantMapView: UIView {
    private lazy var mapView: MKMapView = {
        let map = MKMapView(frame: .zero)
        map.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(map)
        map.boundToSuperView()
        map.addAnnotations(self.annotations)
        if let firstCoordinate = self.annotations.first?.coordinate {
            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            let region = MKCoordinateRegion(center: firstCoordinate, span: span)
            map.setRegion(region, animated: false)
        }
        return map
    }()
    
    private var annotations: [MKPointAnnotation] = []
    
    init(latitudes: [Double], longitudes: [Double], titles: [String]) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.createAnnotations(latitudes: latitudes, longitudes: longitudes, titles: titles)
        _ = self.mapView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createAnnotations(latitudes: [Double], longitudes: [Double], titles: [String]){
        guard latitudes.count == longitudes.count,
        longitudes.count == titles.count,
        longitudes.count == titles.count
        else { return }
        
        var  annotations: [MKPointAnnotation] = []
        
        for index in 0..<latitudes.count {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: latitudes[index], longitude: longitudes[index])
            annotation.title = titles[index]
            annotations.append(annotation)
        }
        self.annotations = annotations
    }
    
    
}
