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
    var beaconData = [BeaconData]()
    var currentBeaconMajor: Int?
    
    func showDestiny() {
        
    }
    
    func setBeacon(major: NSNumber) {
        currentBeaconMajor = major as? Int
    }
    
    func fetchData() {
        guard let url = URL(string: BeaconURL) else {
            return
        }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if error == nil {
                let decoder = JSONDecoder()
                if let safeData = data {
                    do {
                        let results = try decoder.decode([BeaconData].self, from: safeData)
                        if results.count > 0 {
                            self.beaconData = results
                        }
                        print(results)
                    } catch {
                        print(error)
                    }
                }
            }
        }
        task.resume()
        print("beaconData \(beaconData)")
    }
}
