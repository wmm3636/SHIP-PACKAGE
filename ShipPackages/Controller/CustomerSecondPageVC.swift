//
//  CustomerSecondPageVC.swift
//  ShipPackages
//
//  Created by Waleed Mastour on 9/9/18.
//  Copyright © 2018 Waleed Mastour. All rights reserved.
//

import UIKit
struct shippingInfo {
    init() {
       carType = ""
        description = ""
        time = ""
    }
    
    var carType:String
    var description:String
    var time:String
}
class CustomerSecondPageVC: UIViewController {
    
    @IBOutlet weak var truckType: UISegmentedControl!
    
    @IBOutlet weak var descTextView: BoldBorderTextView!
    var shippingInfo_ = shippingInfo()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  self.navigationController?.popViewController(animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func determineTruckType() {
        if truckType.selectedSegmentIndex == 0 {
            shippingInfo_.carType = "sedan"
        } else if truckType.selectedSegmentIndex == 1 {
            shippingInfo_.carType = "van"
        } else {
            shippingInfo_.carType = "truck"
        }
    }
   
    
    @IBAction func nextStepBtnTapped(_ sender: Any) {
        print(descTextView.text)
        determineTruckType()
        if descTextView.text.isEmpty {
            displayAlertMessage(userMessage: "Description field is required!")
        } else {
            let customerThirdPageVC = self.storyboard?.instantiateViewController(withIdentifier: "CustomerThirdPageVC") as! CustomerThirdPageVC
            shippingInfo_.description = descTextView.text
            customerThirdPageVC.shippingInfo_ = shippingInfo_
            self.navigationController?.pushViewController(customerThirdPageVC, animated: true)
//            self.present(customerThirdPageVC, animated: true)
        }
        
        
    }
    
    @IBAction func previousStepBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func menuSideBtnTapped(_ sender: Any) {
        sideMenuController?.revealMenu()

    }
    
    
    func displayAlertMessage(userMessage : String) {
        let myAlert = UIAlertController(title:"Alert", message:userMessage, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler:nil)
        myAlert.addAction(OKAction)
        present(myAlert, animated: true, completion: nil)
        
    }
    
    
    
}
