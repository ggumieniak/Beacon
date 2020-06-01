//
//  OptionManager.swift
//  Beacon
//
//  Created by user on 01/06/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import Foundation

class OptionManager {
    var salaDB = [SalaDB]()
    
    let serverURL = "http://s35615.s.pwste.edu.pl/DataBaseBeconServer/dbClassroom.php"
    func fetchData() {
        guard let url = URL(string: serverURL) else {
            return
        }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if error == nil {
                let decoder = JSONDecoder()
                if let safeData = data {
                    do {
                    let results = try decoder.decode([SalaDB].self, from: safeData)
                        if results.count > 0 {
                            self.salaDB = results
                        }
                    } catch {
                        print(error)
                        
                    }
                }
            }
        }
        task.resume()
        print("salaDB \(salaDB)")
    }
    func chooseDestiny(pickedRoom: String) -> String {
        for room in salaDB {
            if room.name == pickedRoom {
                return room.id_becon
            }
        }
        return "0"
    }
    func getCountSalaDB() {
        print("\(salaDB.count)")
    }
}
