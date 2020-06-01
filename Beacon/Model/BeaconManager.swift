//
//  BeaconManager.swift
//  Beacon
//
//  Created by user on 01/06/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import Foundation

class BeaconManager {
    let BeaconURL = "http://s35615.s.pwste.edu.pl/DataBaseBeconServer"
    var beaconDB = [BeaconData]()
    var previousBeaconMajor: Int?
    var currentBeaconMajor: Int?
    var distanceToDestiny: Int?
    var destinyBeacon: String?
    var searchingBeacon: BeaconData?
    var currentBeacon: BeaconData?
    
    func showDestiny(destinyBeacon: String) -> String {
        self.destinyBeacon = destinyBeacon
        getBeaconInformationFromDestinyBeacon()
        checkFloor()
        
        return K.Answers.GO_AHEAD
    }
    
    func checkActualDistanceToDestiny() {
        
    }
    
    func checkFloor() {
        if let currentFloor = Int(currentBeacon!.floor), let destinyFloor = Int(searchingBeacon!.floor) {
            
        }
    }
    
    func getBeaconInformationFromDestinyBeacon() {
        for beacon in beaconDB {
            if beacon.major == destinyBeacon {
                searchingBeacon = beacon
            }
        }
    }
    
    func setBeacon(major: NSNumber) {
        let looking = "\(major)"
        currentBeacon = findBeaconByMajor(major: looking)
    }
    
    func findBeaconByMajor(major: String) -> BeaconData {
        for beacon in beaconDB {
            if beacon.major == major {
                return beacon
            }
        }
        return BeaconData(id: "0", idBecon: "0", minor: "0", major: "0", floor: "0")
    }
    
    func fetchData() -> Bool {
        guard let url = URL(string: BeaconURL) else {
            return false
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if error == nil {
                let decoder = JSONDecoder()
                if let safeData = data {
                    do {
                        let results = try decoder.decode([BeaconData].self, from: safeData)
//                        if results.count > 0 {
//                            self.beaconDB = results
//                        }
                        print(results)
                        print("Udalo sie pobrac dane")
                    } catch {
                        print(error)
                    }
                }
            }
        }
        task.resume()
        print("beaconData \(beaconDB)")
        return true
    }
}
