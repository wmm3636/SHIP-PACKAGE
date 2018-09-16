//
//  RoundedLabel.swift
//  ShipPackages
//
//  Created by Waleed Mastour on 9/4/18.
//  Copyright © 2018 Waleed Mastour. All rights reserved.
//

import UIKit

class RoundedLabel: UILabel {
    
    override func awakeFromNib() {
        setUpView()
    }
    
    func setUpView() {
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
        
//        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 3.0
        self.layer.shadowOpacity = 1.0
    }

}
