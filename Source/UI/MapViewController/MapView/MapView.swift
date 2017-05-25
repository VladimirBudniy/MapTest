//
//  MapView.swift
//  MapTest
//
//  Created by Vladimir Budniy on 5/23/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import UIKit
import MapKit

import Mapbox

enum AnnotationViewType {
    case short
    case detail
}

enum MapType {
    case apple
    case mapbox
}

class MapView: UIView {
    
    @IBOutlet var defaultMapView: MKMapView?
    @IBOutlet var mapboxMapView: MGLMapView?
    
    let constants = BarItems()
    var annotationViewType: AnnotationViewType = .short
    var mapType: MapType = .apple
    
    var annotationView: AnnotationView?
    var gestureRecognizer: UILongPressGestureRecognizer?
    
    override func awakeFromNib() {
        self.mapboxMapView?.removeFromSuperview()
    }
    
    // MARK: Private methods
    
    private func createAnnotationView() -> AnnotationView? {
        return self.annotationViewType == .short
            ? UINib.objectWithClass(ShortAnnotationView.self) as? ShortAnnotationView
            : UINib.objectWithClass(DetailAnnotationView.self) as? DetailAnnotationView
    }
    
    private func change<T: UIView, U: UIView>(_ view: T?, with newView: U?) {
        if let view = view, let newView = newView {
            UIView.animate(withDuration: 0.3) {
                view.removeGestureRecognizer(self.gestureRecognizer!)
                newView.addGestureRecognizer(self.gestureRecognizer!)
                view.removeFromSuperview()
                self.addSubview(newView)
            }
        }
    }
    
    // MARK: Public methods
    
    func setMapType(type: MapType) {
        self.mapType = type
        switch type {
        case .apple:
            self.defaultMapView = MKMapView(frame: (self.mapboxMapView?.frame)!)
            self.change(self.mapboxMapView, with: self.defaultMapView)
        default:
            self.mapboxMapView = MGLMapView(frame: (self.defaultMapView?.frame)!)
            self.change(self.defaultMapView, with: self.mapboxMapView)
        }
    }
    
    func setAnnotationViewType(type: AnnotationViewType) {
        self.annotationViewType = type
    }
    
    func add(_ gestureReconizer: UILongPressGestureRecognizer) {
        self.gestureRecognizer = gestureReconizer
        self.defaultMapView?.addGestureRecognizer(gestureReconizer)
    }

    func getCurrentPoint(gestureReconizer: UILongPressGestureRecognizer) -> CLLocationCoordinate2D {
        self.dismissAnnotationView()
        
        let currentPoint = self.mapType == .apple
            ? gestureReconizer.location(in: self.defaultMapView)
            : gestureReconizer.location(in: self.mapboxMapView)
        
        switch self.mapType {
        case .apple:
            let mapView = self.defaultMapView
            return mapView!.convert(currentPoint, toCoordinateFrom: mapView)
        default:
            let mapView = self.mapboxMapView
            return mapView!.convert(currentPoint, toCoordinateFrom: mapView)
        }
    }
    
    func dismissAnnotationView() {
        self.annotationView?.removeFromSuperview()
        self.annotationView = nil
    }
    
    func addAnnotationView(model: ReverseGeocoding?) {
        if let model = model {
            
            switch self.mapType {
            case .apple:
                self.defaultMapView?.setCenter(model.coordinate!, animated: true)
            default:
                self.mapboxMapView?.setCenter(model.coordinate!, animated: true)
            }

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
    
