//
//  DriverRequistDetailsVC.swift
//  ShipPackages
//
//  Created by Waleed Mastour on 9/14/18.
//  Copyright © 2018 Waleed Mastour. All rights reserved.
//

import UIKit
import Firebase

class DriverRequistDetailsVC: UIViewController {
    
    @IBOutlet weak var reminderTextView: UITextView!
    
    var reminderText:String = ""
    var parentView: DriverRequistListVC!
    var key: String = ""
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setText(text:String){
        reminderText = text
        if isViewLoaded{
            reminderTextView.text = text
        }
    }

}
