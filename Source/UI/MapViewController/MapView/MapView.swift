//
//  MapView.swift
//  MapTest
//
//  Created by Vladimir Budniy on 5/23/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import UIKit
import MapKit

class MapView: UIView, MKMapViewDelegate, CLLocationManagerDelegate {
    @IBOutlet var defaultMapView: MKMapView?
    
    let locationManager = CLLocationManager()
//    var model: ReverseGeocoding?
//    var annotation: Annotation?
    var annotationView: AnnotationView?
    
    override func awakeFromNib() {
//        self.setUserLocation()
//        self.defaultMapView?.delegate = self
    }
    
    // MARK: Public methods

//    func addAnnotation(_ model: ReverseGeocoding) {        
//        let mapView = self.defaultMapView
//        if let coordinate = model.coordinate {
//            self.model = model
//            let annotation = Annotation(coordinate: coordinate)
//            mapView?.addAnnotation(annotation)
//            mapView?.setCenter(annotation.coordinate, animated: true)
//            self.annotation = annotation
//        }
//    }
    
    func getCurrentPoint(gestureReconizer: UILongPressGestureRecognizer) -> CLLocationCoordinate2D {
        let mapView = self.defaultMapView
        let currentPoint = gestureReconizer.location(in: mapView)
        
        return mapView!.convert(currentPoint,toCoordinateFrom: mapView)
    }
    
    func dismissAnnotationView() {
        self.annotationView?.removeFromSuperview()
        
//        if let annotation = self.annotation {
//            self.defaultMapView?.removeAnnotation(annotation)
//            self.annotation = nil
//        }
    }
    
    // MARK: Private methods
    
//    fileprivate func setUserLocation() {
//        let locationManager = self.locationManager
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestAlwaysAuthorization()
//        locationManager.startUpdatingHeading()
//        locationManager.startUpdatingLocation()
//    }
    
//    fileprivate func setNewRegion(location: CLLocation?) {
//        if let latitude = location?.coordinate.latitude, let longitude = location?.coordinate.longitude {
//            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//            let region = MKCoordinateRegion(center: coordinate,
//                                            span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
//            self.defaultMapView?.setRegion(region, animated: true)
//        }
//    }
    
    func addAnnotationView(model: ReverseGeocoding?) {
        if let view = Bundle.main.loadNibNamed("AnnotationView", owner: self, options: nil)?.first as? AnnotationView  {
            view.center = CGPoint(x: (self.frame.size.width / 2),
                                  y: (self.frame.size.height / 2) - (view.frame.size.height / 2))
            view.fillWith(model: model)
            self.annotationView = view
            self.addSubview(view)
        }
    }

//    // MARK: MKMapViewDelegate methods
//    
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        self.addAnnotationView()
//        
//        return MKAnnotationView()
//    }
//    
//    // MARK: CLLocationManagerDelegate methods
//    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        manager.stopUpdatingLocation()
//        self.setNewRegion(location: locations.first)
//    }
    
}
