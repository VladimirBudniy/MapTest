//
//  AnnotationView.swift
//  MapTest
//
//  Created by Vladimir Budniy on 5/24/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import UIKit

class AnnotationView: UIView {

    @IBOutlet var cityName: UILabel?
    @IBOutlet var streetName: UILabel?
    @IBOutlet var postCode: UILabel?

    func fillWith(model: ReverseGeocoding?) {
        self.cityName?.text = model?.name
        self.streetName?.text = model?.city
        self.postCode?.text = model?.streetName
    }
    
}
