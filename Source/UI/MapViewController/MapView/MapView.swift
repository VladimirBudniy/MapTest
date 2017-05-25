//
//  MapView.swift
//  MapTest
//
//  Created by Vladimir Budniy on 5/23/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import UIKit
import MapKit

enum AnnotationViewType {
    case short
    case detail
}

class MapView: UIView, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet var defaultMapView: MKMapView?
    
    let constants = BarItems()
    let locationManager = CLLocationManager()
    var annotationViewType: AnnotationViewType = .short
    var annotationView: AnnotationView?
    
    func createAnnotationView() -> AnnotationView? {
        return self.annotationViewType == .short
            ? UINib.objectWithClass(ShortAnnotationView.self) as? ShortAnnotationView
            : UINib.objectWithClass(DetailAnnotationView.self) as? DetailAnnotationView
    }
    
    // MARK: Public methods
    
    func setAnnotationViewType(type: AnnotationViewType) {
        self.annotationViewType = type
    }
    
    func getCurrentPoint(gestureReconizer: UILongPressGestureRecognizer) -> CLLocationCoordinate2D {
        self.dismissAnnotationView()
        
        let mapView = self.defaultMapView
        let currentPoint = gestureReconizer.location(in: mapView)
        
        return mapView!.convert(currentPoint,toCoordinateFrom: mapView)
    }
    
    func dismissAnnotationView() {
        self.annotationView?.removeFromSuperview()
        self.annotationView = nil
    }
    
    func addAnnotationView(model: ReverseGeocoding?) {
        if let model = model {
            self.defaultMapView?.setCenter(model.coordinate!, animated: true)
            guard let view = self.annotationView else {
                if let view = self.createAnnotationView() {
                    view.center = CGPoint(x: (self.frame.size.width / 2),
                                          y: (self.frame.size.height / 2) - (view.frame.size.height / 2))
                    view.fillWith(model: model)
                    self.annotationView = view
                    self.addSubview(view)
                }
                
                return
            }
            
            view.fillWith(model: model)
            self.addSubview(view)
        }
    }
}
    
