//
//  RoundButton.swift
//  Beacon
//
//  Created by user on 24/05/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import UIKit

import UIKit

@IBDesignable
class RoundButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 0{
        didSet{
        self.layer.cornerRadius = cornerRadius
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0{
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }

    @IBInspectable var borderColor: UIColor = UIColor.clear{
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }
}
