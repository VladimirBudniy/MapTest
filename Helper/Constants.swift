//
//  Constants.swift
//  MapTest
//
//  Created by Vladimir Budniy on 5/25/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import Foundation

enum AnnotationViewType {
    case short
    case detail
}

enum MapType {
    case apple
    case mapbox
}

struct BarItems {
    var appleMaps = "Apple maps"
    var mapBoxMaps = "MapBox maps"
    
    var detailType = "Detail Inf."
    var shortType = "Short Inf."
}
