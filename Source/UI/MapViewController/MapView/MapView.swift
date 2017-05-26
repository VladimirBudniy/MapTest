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
    
    // MARK: Public methods
    
    func setMapType(type: MapType) {
        self.mapType = type
        self.viewForType(type: type)
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
        return self.coordinate(for: self.currentPoint(for: gestureReconizer))
    }
    
    func dismissAnnotationView() {
        self.annotationView?.removeFromSuperview()
        self.annotationView = nil
    }
    
    func addAnnotationView(model: ReverseGeocoding?) {
        if let model = model {
            guard let view = self.annotationView else {
                if let view = self.createAnnotationView() {
                    view.center = self.viewCenter(for: view)
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
    
    // MARK: Private methods
    
    private func viewForType(type: MapType) {
        switch type {
        case .apple:
            self.defaultMapView = MKMapView(frame: (self.mapboxMapView?.frame)!)
            self.change(self.mapboxMapView, with: self.defaultMapView)
        default:
            self.mapboxMapView = MGLMapView(frame: (self.defaultMapView?.frame)!)
            self.change(self.defaultMapView, with: self.mapboxMapView)
        }
    }
    
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
    
    private func viewCenter(for view: AnnotationView) -> CGPoint {
        return CGPoint(x: (self.frame.size.width / 2),
                       y: (self.frame.size.height / 2) - (view.frame.size.height / 2))
    }
    
    private func currentPoint(for gestureReconizer: UILongPressGestureRecognizer) -> CGPoint {
        return self.mapType == .apple
            ? gestureReconizer.location(in: self.defaultMapView)
            : gestureReconizer.location(in: self.mapboxMapView)
    }
    
    private func coordinate(for point: CGPoint) -> CLLocationCoordinate2D {
        switch self.mapType {
        case .apple:
            let mapView = self.defaultMapView
            return mapView!.convert(point, toCoordinateFrom: mapView)
        default:
            let mapView = self.mapboxMapView
            return mapView!.convert(point, toCoordinateFrom: mapView)
        }
    }
}
    
