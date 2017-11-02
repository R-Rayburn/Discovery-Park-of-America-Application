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
    var locationManager: CLLocationManager!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    startScanning()
                }
            }
        }
    }
    
    func startScanning() {
        let uuid = UUID(uuidString: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5")!
        let beaconRegion = CLBeaconRegion(proximityUUID: uuid, major: 123, minor: 456, identifier: "MyBeacon")
        
        locationManager.startMonitoring(for: beaconRegion)
        locationManager.startRangingBeacons(in: beaconRegion)
    }
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        if beacons.count > 0 {
            updateDistance(beacons[0].proximity)
        } else {
            updateDistance(.unknown)
        }
    }
    
    func updateDistance(_ distance: CLProximity) {
        UIView.animate(withDuration: 0.8) {
            switch distance {
            case .unknown:
                self.view.backgroundColor = UIColor.gray
                
            case .far:
                self.view.backgroundColor = UIColor.blue
                
            case .near:
                self.view.backgroundColor = UIColor.orange
                
            case .immediate:
                self.view.backgroundColor = UIColor.red
            }
        }
    }
}


// TESTING FOR DISTANCE
/*import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager:CLLocationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
    }
    
    
    func rangeBeacons() {
        let uuid = UUID(uuidString: "e2c56bd5-dffb48d2-b060d0f5-a71096e0")!
        let major:CLBeaconMajorValue = 1
        let minor:CLBeaconMinorValue = 238
        let identifier = "MiniBeacon_"
        let region = CLBeaconRegion(proximityUUID: uuid, major: major, minor: minor, identifier: identifier)
        locationManager.startRangingBeacons(in: region)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            rangeBeacons()
        }
    }
    
/*    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        guard let foundBeacon = beacons.first?.proximity else {print("No beacons were found."); return}
        
        let backgroundColors:UIColor = {
            switch foundBeacon {
            case .immediate: return UIColor.green
            case .near: return UIColor.orange
            case .far: return UIColor.red
            case .unknown: return UIColor.yellow
            }
        }()
        
        self.view.backgroundColor = backgroundColors
        
    }*/
    func updateDistance(_ distance: CLProximity) {
        UIView.animate(withDuration: 0.8) {
            switch distance {
            case .unknown:
                self.view.backgroundColor = UIColor.gray
                
            case .far:
                self.view.backgroundColor = UIColor.blue
                
            case .near:
                self.view.backgroundColor = UIColor.orange
                
            case .immediate:
                self.view.backgroundColor = UIColor.red
            }
        }
    }
    
}*/






/*import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    //Sets the beacon region by giving the uuid that the beacon produces and a name for the beacon.
    let region = CLBeaconRegion(proximityUUID: NSUUID(uuidString: "74278BDA-B644-45208F0C720EAF059935")! as UUID, identifier: "MiniBeacon_")
    
    let colors = [238: UIColor(red:84/255, green: 77/255, blue: 160/255, alpha:1)]
    
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
    }*/
    
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
     }
}*/

