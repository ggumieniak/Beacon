//
//  ServerBeacon.swift
//  Beacon
//
//  Created by user on 01/06/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import Foundation

struct BeaconData: Decodable {
    let id: String
    let idBecon: String
    let minor: String
    let major: String
    let floor: String
}
