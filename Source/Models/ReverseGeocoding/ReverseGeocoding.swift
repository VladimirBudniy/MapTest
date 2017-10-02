//
//  ReverseGeocoding.swift
//  MapTest
//
//  Created by Vladimir Budniy on 5/24/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import Foundation
import MapKit

class ReverseGeocoding {

    var delegate: LoadAnnotationDelegate? //  protocol method
    
    // MARK: Class methods
    
    static func geocodeModel(_ coordinate: CLLocationCoordinate2D?, handler: @escaping placemark) { // for handler method
        guard let coordinate = coordinate else { return }
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks , error) in
            if let placemarks = placemarks {
                handler(GeocodingModel(with: placemarks.first))
            }
        }
    }
    
    // MARK: Public methods
    
    func geocodeModel(_ coordinate: CLLocationCoordinate2D?) { // for protocol method
        guard let coordinate = coordinate else { return }
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        CLGeocoder().reverseGeocodeLocation(location) {[weak self] (placemarks , error) in
            if let placemarks = placemarks {
                self?.delegate?.modelLoaded(model: GeocodingModel(with: placemarks.first))
            }
        }
    }
    
    
}
