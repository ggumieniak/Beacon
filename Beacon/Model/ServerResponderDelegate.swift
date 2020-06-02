//
//  ServerResponder.swift
//  Beacon
//
//  Created by user on 02/06/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import Foundation

protocol ServerResponderDelegate {
    func didFinishDownloading(_ sender: BeaconManager)
}
