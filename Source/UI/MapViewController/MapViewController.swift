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
    
    let constants = BarItems()
    
   // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.settingNavigationBar()
        self.addLongPressGestureRecognizer()
    }
    
    // MARK: Private methods
    
    private func settingNavigationBar() {
        let navigationItem = self.navigationItem
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: constants.appleMaps,
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(printAction))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: constants.detailType,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(changeAnnotationViewType))
    }

    private func addLongPressGestureRecognizer() {
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        gesture.minimumPressDuration = 0.2
        gesture.delaysTouchesBegan = true
        gesture.delegate = self
        self.rootView.defaultMapView?.addGestureRecognizer(gesture)
    }
    
    // MARK: Handler method
    
    private func loadAnnotation(with model: ReverseGeocoding) {
        self.rootView.addAnnotationView(model: model)
    }
    
    // MARK: Actions methods
    
    @objc private func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
        if gestureReconizer.state != .ended, gestureReconizer.state != .changed {
            let coordinate = self.rootView.getCurrentPoint(gestureReconizer: gestureReconizer)
            ReverseGeocoding.geocodeModel(coordinate, handler: loadAnnotation)
        }
    }
    
    @objc private func printAction() {
        let title = self.navigationItem.leftBarButtonItem?.title
        self.navigationItem.leftBarButtonItem?.title = title == constants.appleMaps ? constants.mapBoxMaps : constants.appleMaps
        
        // change root mapView
    }
    
    @objc private func changeAnnotationViewType() {
        let title = self.navigationItem.rightBarButtonItem?.title
        self.rootView.setAnnotationViewType(type: title == constants.detailType ? AnnotationViewType.detail : AnnotationViewType.short)
        self.navigationItem.rightBarButtonItem?.title = title == constants.detailType ? constants.shortType : constants.detailType
    }
    
    @IBAction func onCancelAnnotationView(_ sender: Any) {
        self.rootView.dismissAnnotationView()
    }
}



