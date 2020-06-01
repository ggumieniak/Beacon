//
//  LoginViewController.swift
//  Beacon
//
//  Created by user on 24/05/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {


    var cel: String?
    var optionManager = OptionManager()
    var beaconManager = BeaconManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beaconManager.fetchData()
        optionManager.fetchData()
        // Do any additional setup after loading the view.
    }


    @IBAction func selectedRoomPressed(_ sender: UIButton) {
        if let napis = sender.titleLabel?.text {
            cel = optionManager.chooseDestiny(pickedRoom: napis)
            performSegue(withIdentifier: K.findWaySegue, sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.findWaySegue {
            let destination = segue.destination as! FindWayViewController
            destination.sala = cel
            destination.beaconManager = beaconManager
        }
    }
}
