//
//  AnnotationView.swift
//  MapTest
//
//  Created by Vladimir Budniy on 5/24/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import UIKit

class AnnotationView: UIView {

    @IBOutlet var placeName: UILabel?
    @IBOutlet var cityName: UILabel?
    @IBOutlet var streetName: UILabel?
    @IBOutlet var countryName: UILabel?
    @IBOutlet var waterPlace: UILabel?
    
    @IBOutlet var cancelButton: UIButton?

    func fillWith(model: ReverseGeocoding?) {
        self.placeName?.text = model?.name
        self.cityName?.text = model?.city
        self.streetName?.text = model?.streetName
        self.countryName?.text = model?.country
        
        if model?.inlandWater == nil {
            self.waterPlace?.text = model?.ocean
        } else {
            self.waterPlace?.text = model?.inlandWater
        }
    }
}
