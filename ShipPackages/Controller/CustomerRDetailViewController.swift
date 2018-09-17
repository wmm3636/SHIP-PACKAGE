//
//  CustomerRDetailViewController.swift
//  ShipPackages
//
//  Created by Waleed Mastour on 4/21/18.
//  Copyright © 2018 Waleed Mastour. All rights reserved.
//

import UIKit
import Firebase

class CustomerRDetailViewController: UIViewController {

    @IBOutlet weak var descriptionTextField: UITextField!
    
    @IBOutlet weak var servedTextField: UITextField!
    
    
    @IBOutlet weak var pickupTextFeild: UITextField!
    
    @IBOutlet weak var dropoffTextField: UITextField!
    
    @IBOutlet weak var assignedTo: UITextField!
    
    var reminderText:String = ""
    var parentView: CustomerRViewController!
    var key: String = ""
    var ref: DatabaseReference!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        ref.child("orders").child(self.key).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let description = value?["description"] as? String ?? ""
            let served = value?["served"] as? String ?? ""
            let pickup = value?["pickuplocation"] as? String ?? ""
            let dropoff = value?["dropofflocation"] as? String ?? ""
            let assignedId = value?["assignedTo"] as? String ?? ""
            self.ref.child("Users/\(assignedId)").observeSingleEvent(of: .value, with: { (snapshot) in
                print(snapshot)
                let val = snapshot.value as? NSDictionary
                let assignedTo = val?["firstName"] as? String ?? ""
                self.assignedTo.text = assignedTo
            }){(err) in
                 print(err.localizedDescription)
                
            }
            self.descriptionTextField.text = description
            self.servedTextField.text = served
            self.pickupTextFeild.text = pickup
            self.dropoffTextField.text = dropoff
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
        self.navigationItem.largeTitleDisplayMode = .never
        self.hideKeyboard()
    }
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
