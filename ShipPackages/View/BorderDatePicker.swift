//
//  BorderDatePicker.swift
//  ShipPackages
//
//  Created by Waleed Mastour on 9/11/18.
//  Copyright © 2018 Waleed Mastour. All rights reserved.
//

import UIKit

class BorderDatePicker: UIDatePicker {
    override func awakeFromNib() {
        setUpView()
    }
    
    func setUpView(){
        self.layer.borderWidth = 3
        self.layer.backgroundColor = UIColor.lightGray.cgColor
    }
    
}

