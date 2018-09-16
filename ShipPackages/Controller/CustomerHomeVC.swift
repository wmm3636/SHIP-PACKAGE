//
//  CustomerHomeVC.swift
//  ShipPackages
//
//  Created by Waleed Mastour on 9/9/18.
//  Copyright © 2018 Waleed Mastour. All rights reserved.
//

import UIKit



class CustomerHomeVC: UIViewController {
    
    @IBOutlet weak var selectTime: BorderDatePicker!
    
    var shippingInfo_ = shippingInfo()

    var delegate: CenterVCDelegate?
    static var vc:CustomerHomeVC = CustomerHomeVC()
    override func viewDidLoad() {
        super.viewDidLoad()
        CustomerHomeVC.vc = self
        // Do any additional setup after loading the view.
    }
    
    func donePick(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        shippingInfo_.time = dateFormatter.string(from: selectTime.date)
//        self.view.endEditing(true)
    }

    
    @IBAction func menuBtnTapped(_ sender: Any) {
      //  delegate?.toggleLeftPanel()
        
        sideMenuController?.revealMenu()
    }
    
    @IBAction func nextBtnTapped(_ sender: Any) {
        let CustomerSecondPageVC = self.storyboard?.instantiateViewController(withIdentifier: "CustomerSecondPageVC") as! CustomerSecondPageVC
        donePick()

        CustomerSecondPageVC.shippingInfo_ = shippingInfo_
        self.navigationController?.pushViewController(CustomerSecondPageVC, animated: true)
    }
    
    
}
