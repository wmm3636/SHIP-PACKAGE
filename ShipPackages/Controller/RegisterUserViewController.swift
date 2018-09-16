//
//  RegisterUserViewController.swift
//  ShipPackages
//
//  Created by Waleed Mastour on 9/8/18.
//  Copyright © 2018 Waleed Mastour. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import SideMenuSwift

class RegisterUserViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var firstNameTextField: RoundedCornerTextField!
    @IBOutlet weak var lastNameTextField: RoundedCornerTextField!
    @IBOutlet weak var emailTextField: RoundedCornerTextField!
    @IBOutlet weak var passwordTextField: RoundedCornerTextField!
    @IBOutlet weak var repeatedPasswordTextField: RoundedCornerTextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        
        view.bindtokeyboard()
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleScreenTap(sender:)))
        self.view.addGestureRecognizer(tap )
    }
//    override func viewWillAppear(_ animated: Bool) {
//        truckTypeControl.isHidden = true
//    }
    
    @objc func handleScreenTap(sender: UITapGestureRecognizer) {
        self.view.endEditing(true )
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setRootUIwindow(){
        if appDelegate.cureentuserType == .custmer{
            let _sideMenuController = self.storyboard?.instantiateViewController(withIdentifier: "SideMenuController") as! SideMenuController
            
            appDelegate.window?.rootViewController = _sideMenuController
            appDelegate.window?.makeKeyAndVisible()
            
            present(_sideMenuController, animated: false, completion: nil)
            
        }else{
            let _sideMenuController = self.storyboard?.instantiateViewController(withIdentifier: "SideMenuController") as! SideMenuController
            
            appDelegate.window?.rootViewController = _sideMenuController
            appDelegate.window?.makeKeyAndVisible()
            
            present(_sideMenuController, animated: false, completion: nil)
            
        }
        
    }
    
    @IBAction func signupBtnTapped(_ sender: Any) {
        // validate required fields are not empty
        if (firstNameTextField.text?.isEmpty)! || (lastNameTextField.text?.isEmpty)! || (emailTextField.text?.isEmpty)! || (passwordTextField.text?.isEmpty)! || (repeatedPasswordTextField.text?.isEmpty)! {
            displayAlertMessage(userMessage: "All fields are required !")
            return
        }
        // validate password length
        if ((passwordTextField.text?.count)! < 6){
            self.displayAlertMessage(userMessage: "Password must be at least 6 characters!")
            return
        }
        // validate password
        if (passwordTextField.text?.elementsEqual(repeatedPasswordTextField.text!) != true){
            displayAlertMessage(userMessage: "Password does not match !")
            return
        }
        
        let email = emailTextField.text
        let pass = passwordTextField.text
        Auth.auth().createUser(withEmail: email!, password: pass!) { (user, error) in
            if user != nil {
                let firstName = self.firstNameTextField.text
                let lastName = self.lastNameTextField.text
                if let user = user {
                    
                    if self.segmentedControl.selectedSegmentIndex == 0 {
                        let userData = ["firstName": firstName!, "lastName": lastName!] as [String: Any]
                        DataService.instance.createFirebaseDBUser(uid: user.user.uid, userData: userData, isDriver: false)
                        let customerHomeVC = self.storyboard?.instantiateViewController(withIdentifier: "CustomerHomeVC")
                        
                        self.setRootUIwindow()
                    } else {
//                        self.truckTypeControl.isHidden = false
                        let userData = ["firstName": firstName!, "lastName": lastName!, "userIsDriver": true, "isPickupModeEnabled": false, "driverIsOnTrip": false, "approved": false] as [String: Any]
                        DataService.instance.createFirebaseDBUser(uid: user.user.uid, userData: userData, isDriver: true)
                        self.setRootUIwindow()
                    }
                }
            } else {
                self.displayAlertMessage(userMessage: "This email is already exist!")
            }
        }
        
    }
    
    
    @IBAction func haveAccountBtnTapped(_ sender: Any) {
        let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.present(loginVC, animated: true)
    }
    
    
    func displayAlertMessage(userMessage : String) {
        let myAlert = UIAlertController(title:"Alert", message:userMessage, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler:nil)
        myAlert.addAction(OKAction)
        present(myAlert, animated: true, completion: nil)
        
    }
    
    
}
