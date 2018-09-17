 //
//  LoginVC.swift
//  ShipPackages
//
//  Created by Waleed Mastour on 9/3/18.
//  Copyright © 2018 Waleed Mastour. All rights reserved.
//

import UIKit
import Firebase
import SideMenuSwift
class LoginVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailField: RoundedCornerTextField!
    
    @IBOutlet weak var passwordField: RoundedCornerTextField!
    
//    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var authBtn: RoundedShadowButton!
    
    override func viewWillAppear(_ animated: Bool) {
        if Auth.auth().currentUser?.email != nil{
            
            setRootUIwindow()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        emailField.delegate = self
//        passwordField.delegate = self
        
   
        
        view.bindtokeyboard()
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleScreenTap(sender:)))
        self.view.addGestureRecognizer(tap )
    }
    
    @objc func handleScreenTap(sender: UITapGestureRecognizer) {
        self.view.endEditing(true )
    }
    
    @IBAction func signupBtnTapped(_ sender: Any) {
        let signup = self.storyboard?.instantiateViewController(withIdentifier: "RegisterUserViewController") as! RegisterUserViewController
        
        self.present(signup, animated: true)
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
    
    @IBAction func authBtnWasPressed(_ sender: Any) {
        // check all fields are entered
        if (emailField.text?.isEmpty)! || (passwordField.text?.isEmpty)! {
            displayAlertMessage(userMessage: "Enter username and password")
        }
        Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!) { (user, Error) in
            if user != nil {
                var ref: DatabaseReference!
                ref = Database.database().reference()
                let user = Auth.auth().currentUser
                let uid = user?.uid
                
                
                ref.child("drivers").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
                    let value = snapshot.value as? NSDictionary
                    let driver = value?["userIsDriver"] as? Bool ?? false
                    if driver{
                        appDelegate.cureentuserType = .driver
                        self.setRootUIwindow()
                        
                    }else{
                        appDelegate.cureentuserType = .custmer
                        self.setRootUIwindow()
//                        self.performSegue(withIdentifier: "CustomerHomeVC", sender: nil)
                    }
                }) { (error) in
                    print(error.localizedDescription)
                }
                //                let homePageViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomePageViewController") as! HomePageViewController
                //                self.present(homePageViewController, animated: true, completion: nil)
            } else {
                self.displayAlertMessage(userMessage: "username does not exist")
            }
        }
    }
    
    func displayAlertMessage(userMessage : String) {
        let myAlert = UIAlertController(title:"Alert", message:userMessage, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler:nil)
        myAlert.addAction(OKAction)
        present(myAlert, animated: true, completion: nil)
        
    }
 }
