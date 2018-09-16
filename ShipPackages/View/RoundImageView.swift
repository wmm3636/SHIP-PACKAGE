 //
//  RoundImageView.swift
//  ShipPackages
//
//  Created by Waleed Mastour on 9/1/18.
//  Copyright © 2018 Waleed Mastour. All rights reserved.
//

import UIKit

class RoundImageView: UIImageView {
    
    override func awakeFromNib() {
        setUpView() 
    }
    
    func setUpView() {
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }

}
