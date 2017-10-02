//
//  GeocodingModel.swift
//  MapTest
//
//  Created by Vladimir_Budniy on 10/2/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import Foundation
import MapKit

typealias placemark = (GeocodingModel) -> () //  handler method

class GeocodingModel {
    
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
}

