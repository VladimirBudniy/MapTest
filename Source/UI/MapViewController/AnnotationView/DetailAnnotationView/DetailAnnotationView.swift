//
//  DetailAnnotationView.swift
//  MapTest
//
//  Created by Vladimir Budniy on 5/25/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import UIKit

class DetailAnnotationView: AnnotationView {

    @IBOutlet var streetLabel: UILabel?
    @IBOutlet var waterLabel: UILabel?
    
    @IBOutlet var placeName: UILabel?
    @IBOutlet var cityName: UILabel?
    @IBOutlet var streetName: UILabel?
    @IBOutlet var countryName: UILabel?
    @IBOutlet var waterPlace: UILabel?
    
    @IBOutlet var cancelButton: UIButton?
    
    override func fillWith(model: GeocodingModel?) {
        self.placeName?.text = model?.name
        self.cityName?.text = model?.city
        self.streetName?.text = model?.streetName
        self.countryName?.text = model?.country
        
        if model?.streetName == nil {
            self.streetLabel?.text = "state :"
            self.streetName?.text = model?.state
        } else {
            self.streetLabel?.text = "street :"
            self.streetName?.text = model?.streetName
        }
        
        if model?.inlandWater == nil && model?.ocean != nil {
            self.waterLabel?.text = "ocean :"
            self.waterPlace?.text = model?.ocean
        } else {
            self.waterLabel?.text = "river/lake :"
            self.waterPlace?.text = model?.inlandWater
        }
    }
}
