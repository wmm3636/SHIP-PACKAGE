//
//  RoundedCornerTextField.swift
//  ShipPackages
//
//  Created by Waleed Mastour on 9/3/18.
//  Copyright © 2018 Waleed Mastour. All rights reserved.
//

import UIKit

class RoundedCornerTextField: UITextField {
        
    override func awakeFromNib() {
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = self.frame.height / 2
        
    }

}
