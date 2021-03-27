//
//  BeaconManager.swift
//  Beacon
//
//  Created by user on 01/06/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import Foundation

class BeaconManager {
    var beaconDB = [BeaconData]()
    var destinyBeacon: String?
    var previousBeacon: BeaconData?
    var searchingBeacon: BeaconData?
    var distance: Int?
    var previousStep: Int?
    var serverRsponder: ServerResponderDelegate?
    var currentStep: Int? {
        willSet {
            if currentStep != nil {
            previousStep = currentStep
            }
        }
    }
    var currentBeacon: BeaconData? {
        willSet {
            if currentBeacon != nil {
                previousBeacon = currentBeacon
            }
        }
    }
    
    func checkDestiny() -> String {
        switch checkFloor() {
        case -1:
            return K.Answers.GO_UP
        case 1:
            return K.Answers.GO_DOWN
        case 0:
            return getDistanceAnswer()
        default:
            return "Brak odpowiedzi"
        }
    }

    
    func checkFloor() -> Int {
        if let currentFloor = Int(currentBeacon!.floor), let destinyFloor = Int(searchingBeacon!.floor) {
            let wynik = currentFloor - destinyFloor
            self.currentStep = wynik
            print("Roznica pieter to \(wynik)")
            return abs(wynik)
        }
        return 0
    }
    
    func getDistanceAnswer() -> String {
        if previousBeacon == nil {
            currentStep = checkDistance()
            if currentStep == 0 {
                return K.Answers.END
            }
            return K.Answers.GOOD_FLOOR_GO_SOMEWHERE
        }
        currentStep = checkPreviousStep()
        if userWentWrongSide() {
            return K.Answers.GO_BACK
        } else {
            if currentStep == 0 {
                return K.Answers.END
            } else {
                return K.Answers.GO_AHEAD
            }
        }
    }
        
    func checkDistance() -> Int {
        if let currentDistance = Int(currentBeacon!.abstractLenght), let searchDistance = Int(searchingBeacon!.abstractLenght) {
            let wynik = abs(searchDistance - currentDistance)
            distance = wynik
            print("Roznica dystansu to \(wynik)")
            return wynik
        }
        return -1
    }
    
    func userWentWrongSide() -> Bool {
        return previousStep! > currentStep!
    }
    
    func checkPreviousStep() -> Int {
        if let currentStep = Int(currentBeacon!.abstractLenght), let previousStep = Int(previousBeacon!.abstractLenght) {
            let wynik = abs(previousStep - currentStep)
            self.currentStep = wynik
            print("Roznica dystansu to \(wynik)")
            return wynik
        }
        return -1
    }
    

    
    func setUpDestinyBeacon(by lookingForBeacon: String) {
        for beacon in beaconDB {
            if beacon.id == lookingForBeacon {
                searchingBeacon = beacon
            }
        }
    }
    
    func setBeacon(major: NSNumber) {
        let looking = "\(major)"
        currentBeacon = findBeaconByMajor(major: looking)
        print("Obecny beacon \(currentBeacon?.major)")
    }
    
    func findBeaconByMajor(major: String) -> BeaconData {
        for beacon in beaconDB {
            if beacon.major == major {
                return beacon
            }
        }
        return BeaconData(id: "0", idBecon: "0", minor: "0", major: "0", floor: "0",abstractLenght: "0")
    }
    
    func fetchData() {
        guard let url = URL(string: db.BeaconURL) else {
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
                            self.beaconDB = results
                        }
                        self.dataCompleteDownloaded()
                    } catch {
                        print(error)
                    }
                }
            }
        }
        task.resume()
        print("beaconData \(beaconDB)")
    }
    func dataCompleteDownloaded() {
        self.serverRsponder?.didFinishDownloading(self)
    }
}
