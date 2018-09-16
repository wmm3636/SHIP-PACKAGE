//
//  ProfileVC.swift
//  ShipPackages
//
//  Created by Waleed Mastour on 9/12/18.
//  Copyright © 2018 Waleed Mastour. All rights reserved.
//

import UIKit
import Firebase
import SideMenuSwift

class ProfileVC: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var userTypeTextField: UITextField!
    
    var ref: DatabaseReference!
    
    func updateView(firstName:String, lastName:String, userType: String){
        firstNameTextField.text = firstName
        lastNameTextField.text = lastName
        userTypeTextField.text = userType
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Auth.auth().currentUser)
        let user = Auth.auth().currentUser
        let uid = user?.uid
        print("User ID:")
        print(uid)
        
//        ref.child("customers").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
//            if snapshot.hasChild(uid!){
//
//                print("true")
//
//            }else{
//
//                print("false")
//            }
//
//
//        })
//        if appDelegate.cureentuserType == .driver {
//            ref.child("drivers").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
//                let value = snapshot.value as? NSDictionary
//                let firstName = value?["firstName"] as? String ?? ""
//                let lastName = value?["lastName"] as? String ?? ""
//                let userType = "Driver"
//
//                self.updateView(firstName: firstName, lastName:lastName, userType: userType)
//
//            }) { (error) in
//                print(error.localizedDescription)
//            }
//        } else {
//            ref.child("customers").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
//                let value = snapshot.value as? NSDictionary
//                let firstName = value?["firstName"] as? String ?? ""
//                let lastName = value?["lastName"] as? String ?? ""
//                let userType = "Customer"
//
//                self.updateView(firstName: firstName, lastName:lastName, userType: userType)
//
//            }) { (error) in
//                print(error.localizedDescription)
//            }
//        }

//        self.hideKeyboard()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func resetPasswordButtonTabbed(_ sender: Any) {
        let user = Auth.auth().currentUser
        let email = user?.email
        Auth.auth().sendPasswordReset(withEmail: email!, completion: nil)
        self.displayAlertMessage(userMessage: "an email has been sent to you to reset your password")
    }
    
    @IBAction func saveChangesButtonTabbed(_ sender: Any) {
        let user = Auth.auth().currentUser
        let uid = user?.uid
        let firstName:String = firstNameTextField.text!
        let lastName: String = lastNameTextField.text!
        let userType: String = userTypeTextField.text!
        self.ref.child("Users").child(uid!).setValue(["firstName":firstName,"lastName": lastName, "userType": userType])
        self.updateView(firstName: firstName, lastName: lastName, userType: userType)
        self.displayAlertMessage(userMessage: "Your profile has been updated")
        
    }
    

    
    
    func displayAlertMessage(userMessage : String) {
        let myAlert = UIAlertController(title:"Confirm", message:userMessage, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler:nil)
        myAlert.addAction(OKAction)
        present(myAlert, animated: true, completion: nil)
    }
    
    
    
    @IBAction func deleteMyAccountButton(_ sender: Any) {
        let user = Auth.auth().currentUser
        user?.delete(completion: { (error) in
            if let error = error {
                self.displayAlertMessage(userMessage: error.localizedDescription)
            } else {
//                let SignInViewController = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
//                self.present(SignInViewController, animated: true, completion: nil)
//                self.displayAlertMessage(userMessage: "You have successfully deleted your account!")
            }
        })
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */

    @IBAction func menuSideBtnTapped(_ sender: Any) {
        sideMenuController?.revealMenu()
    }
    
}
