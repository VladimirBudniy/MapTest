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
    var annotationView: AnnotationView?
    
    // MARK: Public methods
    
    func getCurrentPoint(gestureReconizer: UILongPressGestureRecognizer) -> CLLocationCoordinate2D {
        self.dismissAnnotationView()
        
        let mapView = self.defaultMapView
        let currentPoint = gestureReconizer.location(in: mapView)
        
        return mapView!.convert(currentPoint,toCoordinateFrom: mapView)
    }
    
    func dismissAnnotationView() {
        self.annotationView?.removeFromSuperview()
    }

    func addAnnotationView(model: ReverseGeocoding?) {
        if let model = model {
            self.defaultMapView?.setCenter(model.coordinate!, animated: true)
            guard let view = self.annotationView  else {
                if let view = UINib.objectWithClass(AnnotationView.self) as? AnnotationView {
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
    
