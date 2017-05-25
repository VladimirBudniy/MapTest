//
//  ShortAnnotationView.swift
//  MapTest
//
//  Created by Vladimir Budniy on 5/25/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import UIKit

class ShortAnnotationView: AnnotationView {
    @IBOutlet var cityName: UILabel?
    @IBOutlet var countryName: UILabel?
    
    @IBOutlet var cancelButton: UIButton?
    
    override func fillWith(model: ReverseGeocoding?) {
        self.cityName?.text = model?.city
        self.countryName?.text = model?.country
        
    }
}
