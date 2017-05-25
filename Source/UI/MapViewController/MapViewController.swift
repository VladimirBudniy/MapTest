//
//  MapViewController.swift
//  MapTest
//
//  Created by Vladimir Budniy on 5/23/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//


import UIKit
import CoreLocation
import MapKit
class MapViewController: UIViewController, ViewControllerRootView, UIGestureRecognizerDelegate {
    
    typealias RootViewType = MapView
    
   // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addLongPressGestureRecognizer()
    }
    
    // MARK: Private methods
    
    private func addLongPressGestureRecognizer() {
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        gesture.minimumPressDuration = 0.2
        gesture.delaysTouchesBegan = true
        gesture.delegate = self
        self.rootView.defaultMapView?.addGestureRecognizer(gesture)
    }
    
    private func loadAnnotation(with model: ReverseGeocoding) {
        self.rootView.addAnnotationView(model: model)
    }
    
    @objc private func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
        if gestureReconizer.state != .ended, gestureReconizer.state != .changed {
            let coordinate = self.rootView.getCurrentPoint(gestureReconizer: gestureReconizer)
            ReverseGeocoding.geocodeModel(coordinate, handler: loadAnnotation)
        }
    }
    
    @IBAction func onCancelAnnotationView(_ sender: Any) {
        self.rootView.dismissAnnotationView()
    }

}



