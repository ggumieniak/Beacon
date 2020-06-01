//
//  BeaconFromServer.swift
//  Beacon
//
//  Created by user on 01/06/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import Foundation

struct BeaconFromServer: Decodable {
    let idBecon: String
    let minor: Int
    let major: Int
    let floor: Int
    let abstractLenght: Int
}
