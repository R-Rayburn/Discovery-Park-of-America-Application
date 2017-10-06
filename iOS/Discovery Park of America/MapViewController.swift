//
//  MapViewController.swift
//  Discovery Park of America
//
//  Created by Paul Gosser on 9/5/17.
//  Copyright © 2017 Paul Gosser. All rights reserved.
// WHat the heck is this crap

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    //Sets the beacon region by giving the uuid that the beacon produces and a name for the beacon.
    let region = CLBeaconRegion(proximityUUID: NSUUID(uuidString: "2B162531-FD29-4758-85B4-555A6DFF00FF")! as UUID, identifier: "Beacon_01")
    
    let colors = [63449: UIColor(red:84/255, green: 77/255, blue: 160/255, alpha:1)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.authorizedWhenInUse){
            locationManager.requestWhenInUseAuthorization()
        }
        locationManager.startRangingBeacons(in: region)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [AnyObject], in region: CLBeaconRegion) {
        let knownBeacons = beacons.filter{ $0.proximity != CLProximity.unknown}
        if(knownBeacons.count > 0) {
            let closestBeacon = knownBeacons[0] as! CLBeacon
            self.view.backgroundColor = self.colors[closestBeacon.minor.intValue]
        }
        //print(beacons)
    }
    
    /*    var mapView: MKMapView!
     var locationManager: CLLocationManager?
     
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
     
     segmentedControl.addTarget(self, action: #selector(MapViewController.mapTypeChanged(_:)), for: .valueChanged)
     
     segmentedControl.translatesAutoresizingMaskIntoConstraints = false
     view.addSubview(segmentedControl)
     
     let topConstraint = segmentedControl.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 8)
     
     let margins = view.layoutMarginsGuide
     let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
     let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
     
     topConstraint.isActive = true
     leadingConstraint.isActive = true
     trailingConstraint.isActive = true
     
     initLocalizationButton(segmentedControl)
     }*/
    
    
    /*    @objc func mapTypeChanged(_ segControl: UISegmentedControl){
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
     
     func initLocalizationButton(_ anyView: UIView!){
     let localizationButton = UIButton.init(type: .system)
     localizationButton.setTitle("Localization", for: .normal)
     localizationButton.translatesAutoresizingMaskIntoConstraints = false
     view.addSubview(localizationButton)
     
     //Constraints
     
     let topConstraint = localizationButton.topAnchor.constraint(equalTo:anyView
     .topAnchor, constant: 32)
     let leadingConstraint = localizationButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor)
     let trailingConstraint = localizationButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
     
     topConstraint.isActive = true
     leadingConstraint.isActive = true
     trailingConstraint.isActive = true
     
     localizationButton.addTarget(self, action: #selector(MapViewController.showLocalization(sender:)), for: .touchUpInside)
     }
     
     @objc func showLocalization(sender: UIButton!){
     locationManager?.requestWhenInUseAuthorization()
     mapView.showsUserLocation = true //fire up the method mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation)
     }
     
     func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
     //This is a method from MKMapViewDelegate, fires up when the user`s location changes
     let zoomedInCurrentLocation = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 500, 500)
     mapView.setRegion(zoomedInCurrentLocation, animated: true)
     }*/
}

