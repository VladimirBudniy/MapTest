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
class MapViewController: UIViewController, ViewControllerRootView, UIGestureRecognizerDelegate, LoadAnnotationDelegate {

    typealias RootViewType = MapView

    let constants = BarItems()

    let model = ReverseGeocoding() // for protocol
    
   // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.model.delegate = self
        self.settingNavigationBar()
        self.addLongPressGestureRecognizer()
    }
    
    // MARK: Private methods
    
    private func settingNavigationBar() {
        let navigationItem = self.navigationItem
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: constants.mapBoxMaps,
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(changeMapType))
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
        self.rootView.add(gesture)
    }
    
//    // MARK: Handler method
//    
//    private func loadAnnotation(with model: GeocodingModel) {
//        self.rootView.addAnnotationView(model: model)
//    }
    
    // MARK: Protocol method
    
    func modelLoaded(model: GeocodingModel) {
        self.rootView.addAnnotationView(model: model)
    }
    
    // MARK: Actions methods
    
    @objc private func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
        if gestureReconizer.state != .ended, gestureReconizer.state != .changed {
            let coordinate = self.rootView.getCurrentPoint(gestureReconizer: gestureReconizer)
//            ReverseGeocoding().geocodeModel(coordinate, handler: loadAnnotation) //  handler method
            self.model.geocodeModel(coordinate) //  handler method
        }
    }
    
    @objc private func changeMapType() {
        let title = self.navigationItem.leftBarButtonItem?.title
        self.rootView.setMapType(type: title == constants.mapBoxMaps ? MapType.mapbox : MapType.apple)
        self.navigationItem.leftBarButtonItem?.title = title == constants.mapBoxMaps ? constants.appleMaps : constants.mapBoxMaps
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



