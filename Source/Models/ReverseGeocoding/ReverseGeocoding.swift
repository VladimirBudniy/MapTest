//
//  ReverseGeocoding.swift
//  MapTest
//
//  Created by Vladimir Budniy on 5/24/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import Foundation
import MapKit

typealias placemark = (ReverseGeocoding) -> () //  handler method

class ReverseGeocoding {
    
    var delegate: LoadAnnotationDelegate? //  protocol method
    
    var coordinate: CLLocationCoordinate2D?
    var name: String?
    var streetName: String?
    var city: String?
    var postCode: String?
    var country: String?
    var subLocality: String?
    var state: String?
    var inlandWater: String?
    var ocean: String?
    var areasOfInterest: [String]?
    
    convenience init() {
        self.init(with: nil)
    }
    
    init(with placemark: CLPlacemark?) {
        self.coordinate = placemark?.location?.coordinate
        self.name = placemark?.name
        self.streetName = placemark?.thoroughfare
        self.city = placemark?.locality
        self.postCode = placemark?.postalCode
        self.country = placemark?.country
        self.subLocality = placemark?.subLocality
        self.state = placemark?.administrativeArea
        self.inlandWater = placemark?.inlandWater
        self.ocean = placemark?.ocean
        self.areasOfInterest = placemark?.areasOfInterest
    }
    
    // MARK: Class methods
    
    static func geocodeModel(_ coordinate: CLLocationCoordinate2D?, handler: @escaping placemark) { //  handler method
        guard let coordinate = coordinate else { return }
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        geocoder.reverseGeocodeLocation(location) { (placemarks , error) in
            if let placemarks = placemarks {
                handler(ReverseGeocoding(with: placemarks.first))
            }
        }
    }
    
    // MARK: Public methods
    
    func geocodeModel(_ coordinate: CLLocationCoordinate2D?) { //  protocol method
        guard let coordinate = coordinate else { return }
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        geocoder.reverseGeocodeLocation(location) {[weak self] (placemarks , error) in
            if let placemarks = placemarks {
                self?.delegate?.annotationLoaded(model: ReverseGeocoding(with: placemarks.first))
            }
        }
    }
    
    
}
