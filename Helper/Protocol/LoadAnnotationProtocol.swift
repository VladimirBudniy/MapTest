//
//  LoadAnnotationProtocol.swift
//  MapTest
//
//  Created by Vladimir Budniy on 5/25/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import Foundation

protocol LoadAnnotationDelegate: class {
    func annotationLoaded(model: ReverseGeocoding)
}
