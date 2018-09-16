//
//  BoldBorderTextView.swift
//  ShipPackages
//
//  Created by Waleed Mastour on 9/9/18.
//  Copyright © 2018 Waleed Mastour. All rights reserved.
//

import UIKit

class BoldBorderTextView: UITextView {

    override func awakeFromNib() {
        setUpView()
    }
    
    func setUpView(){
        self.layer.borderWidth = 3
    }

}
