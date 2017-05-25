//
//  Annotation.swift
//  MapTest
//
//  Created by Vladimir Budniy on 5/24/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import Foundation
import MapKit

class Annotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
