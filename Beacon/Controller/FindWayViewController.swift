//
//  ViewController.swift
//  Beacon
//
//  Created by user on 24/05/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import UIKit
import CoreLocation

class FindWayViewController: UIViewController, CLLocationManagerDelegate {
    
    var sala: String?
    var napis: String?
    @IBOutlet weak var kierunek: UILabel!
    var CzyJestesBeacon: Bool?
    var beaconManager = BeaconManager()
    var listaBeaconowRegion = Set<CLBeaconRegion>()
    
    
    var locationManager: CLLocationManager!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        beaconManager.fetchData()
        print(beaconManager.beaconData)
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        let beaconRegion = region as? CLBeaconRegion
        if state == .inside {
            print("Jestes w zasiegu beaconu")
            locationManager.startRangingBeacons(satisfying: beaconRegion!.beaconIdentityConstraint)
        } else {
            print("Wyszedles z zasiegu beaconu")
            locationManager.stopRangingBeacons(satisfying: beaconRegion!.beaconIdentityConstraint)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        if let beacon = region as? CLBeaconRegion {
            print("Wszedles do strefy beaconu \(beacon.major), jestem w jego zasiegu")
            // pobierz i wyswietl informacje
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        if let beacon = region as? CLBeaconRegion {
            print("Wyszedles ze strefy beaconu \(beacon.major), nie jestes w jego zasiegu")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        print(beacons.count)
        if beacons.count > 0 {
            if region.major == 12903 {
                let proximity = znajdzBeacon(beacons,12903)
                updateDistance(proximity)
            }
        } else {
            kierunek.text = "Zbliz sie do najblizszego beaconu"
        }
    }
    
    func znajdzBeacon(_ beacons: [CLBeacon], _ numer: Int) -> CLProximity {
        for beacon in beacons {
            if beacon.major == numer as NSNumber {
                return beacon.proximity
            }
        }
        return CLProximity.unknown
    }
    
    func updateDistance(_ distance: CLProximity) {
        UIView.animate(withDuration: 0.8) {
            switch distance {
            case .unknown:  // kiedy straci
                self.view.backgroundColor = UIColor.gray
                self.kierunek.text = "Nie wiemy jak daleko jestes"
                
            case .far:
                self.view.backgroundColor = UIColor.blue
                self.kierunek.text = "Jestes daleko"
            case .near:
                self.view.backgroundColor = UIColor.orange
                self.kierunek.text = "Jestes blisko"
                
            case .immediate:
                self.view.backgroundColor = UIColor.red
                self.kierunek.text = "Jestes u celu"
            default:
                print("Brak informacji")
            }
        }
    }
    
}



//    func startScanning() {
//        let uuid = UUID(uuidString: "8492E75F-4FD6-469D-B132-043FE94921D8")!
//        let uuidX = UUID(uuidString: "8492E75F-4FD6-469D-B132-043FE94921D8")!
//        let beaconRegionX = CLBeaconIdentityConstraint(uuid: uuidX, major: 111, minor: 0)
//        let beaconRegion = CLBeaconIdentityConstraint(uuid: uuid, major: 222, minor: 0)
//        locationManager.startRangingBeacons(satisfying: beaconRegion)
//        locationManager.startRangingBeacons(satisfying: beaconRegionX)
//    }
//
// stara funkcja, zostawiona dla przykladu
