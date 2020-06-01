//
//  LoginViewController.swift
//  Beacon
//
//  Created by user on 24/05/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {


    
    @IBOutlet weak var C41Button: UIButton!
    @IBOutlet weak var C42Button: UIButton!
    @IBOutlet weak var C43Button: UIButton!
    @IBOutlet weak var C44Button: UIButton!
    @IBOutlet weak var C45Button: UIButton!
    @IBOutlet weak var C46Button: UIButton!
    @IBOutlet weak var C47Button: UIButton!
    @IBOutlet weak var C48Button: UIButton!
    @IBOutlet weak var C49Button: UIButton!
    @IBOutlet weak var W18Button: UIButton!
    @IBOutlet weak var W19Button: UIButton!
    
    
    var cel: String?
    var optionManager = OptionManager()
    var beaconManager = BeaconManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if beaconManager.fetchData() {
            enableButtons()
            unhiddenButton()
            
        }
        optionManager.fetchData()
        // Do any additional setup after loading the view.
    }

    func enableButtons() {
        C41Button.isEnabled = true
        C41Button.isEnabled = true
        C42Button.isEnabled = true
        C43Button.isEnabled = true
        C44Button.isEnabled = true
        C45Button.isEnabled = true
        C46Button.isEnabled = true
        C47Button.isEnabled = true
        C48Button.isEnabled = true
        C49Button.isEnabled = true
        W18Button.isEnabled = true
        W19Button.isEnabled = true
    }
    
    func unhiddenButton() {
        C41Button.isHidden = false
        C41Button.isHidden = false
        C42Button.isHidden = false
        C43Button.isHidden = false
        C44Button.isHidden = false
        C45Button.isHidden = false
        C46Button.isHidden = false
        C47Button.isHidden = false
        C48Button.isHidden = false
        C49Button.isHidden = false
        W18Button.isHidden = false
        W19Button.isHidden = false
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
            destination.userDestiny = cel
            destination.beaconManager = beaconManager
        }
    }
}
