//
//  AboutAppVC.swift
//  ShipPackages
//
//  Created by Waleed Mastour on 9/11/18.
//  Copyright © 2018 Waleed Mastour. All rights reserved.
//

import UIKit

class AboutAppVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func menuSideBtnTapped(_ sender: Any) {
        sideMenuController?.revealMenu()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
