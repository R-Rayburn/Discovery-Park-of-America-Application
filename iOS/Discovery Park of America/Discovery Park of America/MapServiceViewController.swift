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
    var itemStore: ItemStore!
    var first = true
    var annotations = [CLLocationCoordinate2D]()
    
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
        
        // Coordinates for annotations to be tested.
        var annonCoLat = userLocation.coordinate.latitude + 0.0001
        var annonCoLon = userLocation.coordinate.longitude
        var location = CLLocationCoordinate2DMake(annonCoLat, annonCoLon)
        annotations.append(location)
        annonCoLat = userLocation.coordinate.latitude
        annonCoLon = userLocation.coordinate.longitude + 0.0001
        location = CLLocationCoordinate2DMake(annonCoLat, annonCoLon)
        annotations.append(location)
        annonCoLat = userLocation.coordinate.latitude
        annonCoLon = userLocation.coordinate.longitude - 0.0001
        location = CLLocationCoordinate2DMake(annonCoLat, annonCoLon)
        annotations.append(location)
        
        let diffLat = abs(userLocation.coordinate.latitude - annonCoLat)
        let diffLon = abs(userLocation.coordinate.longitude - annonCoLon)
        let diffThreshold = 0.0002
        if diffLat < diffThreshold, diffLon < diffThreshold, first {
            print("YOU DID IT!!!")
            self.performSegue(withIdentifier: "mapDescription", sender: nil)
        }
        
        let zoomedInCurrentLocation = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 80, 80)
        mapView.setRegion(zoomedInCurrentLocation, animated: true)
        
        // These are test locations for exhibits on map.
        if first {
            var i = 0
            for loc in annotations{
                let annotation = MKPointAnnotation()
                
                annotation.coordinate = loc
                annotation.title = itemStore.allItems[i].name
                annotation.subtitle = "Click to see exhibit info."
                mapView.addAnnotation(annotation)
                i += 1
            }
        }
        first = false
    }
    
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        // https://www.youtube.com/watch?v=hRextIKJCnI
//        let reuseIdentifier = "annotationView"
//        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier) as? MKPinAnnotationView
//        if annotationView == nil {
//            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
//            //annotationView?.tintColor = .green                // do whatever customization you want
//            //annotationView?.canShowCallout = false            // but turn off callout
//        } else {
//            annotationView?.annotation = annotation
//            performSegue(withIdentifier: "mapDescription", sender: nil)
//        }
//
//        return annotationView
//    }
//
    //MARK:- Touch events
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self.view)
        
        var i = 0
        for loc in annotations{
            let mapLoc = CLLocationCoordinate2D(latitude: loc.latitude, longitude: loc.longitude)
            let point = mapView.convert(mapLoc, toPointTo: mapView)
            
            let diffX = abs(location.x - point.x)
            let diffY = abs(location.y - point.y)
            if diffX < 25.0, diffY < 25.0{
                print("TOUCHED ANNOTATION")
                performSegue(withIdentifier: "mapDescription", sender: i)
            }
            i += 1
        }
    }
    
    //MARK:- Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "mapDescription"?:
            var idx: Int
            if let i = sender as! Int?{
                idx = i
            } else{
                idx = 0
            }
            let item = itemStore.allItems[idx]
            let descriptionViewController = segue.destination as! DescriptionViewController
            descriptionViewController.item = item
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
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
