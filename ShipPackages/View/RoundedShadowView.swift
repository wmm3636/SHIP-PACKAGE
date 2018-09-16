//
//  RoundedShadowView.swift
//  ShipPackages
//
//  Created by Waleed Mastour on 9/1/18.
//  Copyright © 2018 Waleed Mastour. All rights reserved.
//

import UIKit

class RoundedShadowView: UIView {
    
    override func awakeFromNib() {
        setUpView()
    }
    
    func setUpView(){
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 5.0
        self.layer.shadowOpacity = 0.3
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowRadius = 5.0
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
    }

}
