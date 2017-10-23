//
//  MapServiceViewController.swift
//  Discovery Park of America
//
//  Created by Paul Gosser on 10/22/17.
//  Copyright © 2017 Paul Gosser. All rights reserved.
//

import UIKit
import MapKit

class MapServiceViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    var mapView: MKMapView!
    var locationManager: CLLocationManager?
    var first = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        locationManager = CLLocationManager()
        
        // unsure
        // https://www.pubnub.com/blog/2015-05-05-getting-started-ios-location-tracking-and-streaming-w-swift-programming-language/
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true
        locationManager?.startUpdatingLocation()
        
        // https://www.youtube.com/watch?v=hRextIKJCnI
        //let span = MKCoordinateSpanMake(10, 10)
        
//        let location = CLLocationCoordinate2DMake(lat + 0.0001, lon)
//        //let region = MKCoordinateRegionMake(location, span)
//        //mapView.setRegion(region, animated: true)
//
//        let annotation = MKPointAnnotation()
//
//        annotation.coordinate = location
//        annotation.title = "TEST"
//        annotation.subtitle = "Exhibit is here"
//        mapView.addAnnotation(annotation)
        
        print("MapViewController loaded its view.")
    }
    
    override func loadView() {
        // Create a map view
        mapView = MKMapView()
        
        // Set it as *the* view of this view controller
        view = mapView
        
        let standardString = NSLocalizedString("Standard", comment: "Standard map view")
        let satelliteString = NSLocalizedString("Satellite", comment: "Satellite map view")
        let hybridString = NSLocalizedString("Hybrid", comment: "Hybrid map view")
        let segmentedControl = UISegmentedControl(items: [standardString, satelliteString, hybridString])
        
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.addTarget(self, action: #selector(MapServiceViewController.mapTypeChanged(_:)), for: .valueChanged)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 8)
        
        let margins = view.layoutMarginsGuide
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        
        //initLocalizationButton(segmentedControl)
    }
    
    
    @objc func mapTypeChanged(_ segControl: UISegmentedControl){
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        //This is a method from MKMapViewDelegate, fires up when the user`s location changes
        
        print(userLocation.coordinate.latitude, userLocation.coordinate.longitude)
        let annonCoLat = userLocation.coordinate.latitude + 0.0001
        let annonCoLon = userLocation.coordinate.longitude
        
        let diffLat = abs(userLocation.coordinate.latitude - annonCoLat)
        let diffLon = abs(userLocation.coordinate.longitude - annonCoLon)
        let diffThreshold = 0.0002
        if diffLat < diffThreshold, diffLon < diffThreshold {
            print("YOU DID IT!!!")
        }
        
        let zoomedInCurrentLocation = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 80, 80)
        mapView.setRegion(zoomedInCurrentLocation, animated: true)
        
        if first {
            let location = CLLocationCoordinate2DMake(annonCoLat, annonCoLon)
            
            let annotation = MKPointAnnotation()
            
            annotation.coordinate = location
            annotation.title = "TEST"
            annotation.subtitle = "Exhibit is here"
            mapView.addAnnotation(annotation)
        }
        
        print("ZOOMED IN")
        first = false
    }
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        // https://www.innofied.com/implement-location-tracking-using-mapkit-in-swift/
//        print(#function)
//        if let oldLocationNew = locations.first as CLLocation?{
//            let oldCoordinates = oldLocationNew.coordinate
//            let newCoordinates = locations.last?.coordinate
//            let oldC = MKMapPointMake(oldCoordinates.latitude, oldCoordinates.longitude)
//            let newC = MKMapPointMake((newCoordinates?.latitude)!, (newCoordinates?.longitude)!)
//            let area = [oldC, newC]
//            let polyline = MKPolyline(points: area, count: area.count)
//            mapView.add(polyline)
//        }
//    }
//
//    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
//        print(#function)
//        let pr = MKPolylineRenderer(overlay: overlay)
//        if (overlay is MKPolyline) {
//            pr.strokeColor = UIColor.red
//            pr.lineWidth = 5
//            return pr
//        }
//
//        return pr
//    }
}
