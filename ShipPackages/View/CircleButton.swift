//
//  CircleButton.swift
//  ShipPackages
//
//  Created by Waleed Mastour on 9/9/18.
//  Copyright © 2018 Waleed Mastour. All rights reserved.
//

import UIKit

class CircleButton: UIButton {

    override func awakeFromNib() {
        setUpView()
    }
    
    func setUpView(){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 1.0
        self.layer.shadowOpacity = 0.5
        self.layer.cornerRadius = self.frame.width / 2
    }
}
