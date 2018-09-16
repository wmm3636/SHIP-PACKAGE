 //
//  LeftSidePanelVC.swift
//  ShipPackages
//
//  Created by Waleed Mastour on 9/2/18.
//  Copyright © 2018 Waleed Mastour. All rights reserved.
//

import UIKit
import Firebase
import SideMenuSwift
 
 struct Menu {
    let id:String
    let name:String
 }
 extension UINavigationController {
    var rootViewController : UIViewController? {
        return viewControllers.first
    }
 }
class LeftSidePanelVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    let driversMenu:[Menu] = [Menu(id: "newRequests", name: "New Requests"),Menu(id: "order", name: "Orders"),Menu(id: "chat", name: "Chat"), Menu(id: "myProfile", name: "My profile"), Menu(id: "contactUs", name: "Contact us"), Menu(id: "aboutApp", name: "About app")]
    let cMenu:[Menu] = [Menu(id: "newOrder", name: "New order"), Menu(id: "orderHistory", name: "Order history"), Menu(id: "chat", name: "Chat"), Menu(id: "myProfile", name: "My profile"), Menu(id: "contactUs", name: "Contact us"), Menu(id: "aboutApp", name: "About app")]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if appDelegate.cureentuserType == .driver {
            return driversMenu.count
        }else{
            return cMenu.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if appDelegate.cureentuserType == .driver {
             cell.textLabel?.text = driversMenu[indexPath.row].name
        }else{
             cell.textLabel?.text = cMenu[indexPath.row].name
        }
       
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if appDelegate.cureentuserType == .driver {
            let id  = driversMenu[indexPath.row].id
            
            switch id {
            case "newRequests":
                print("sdsds")
            case "myProfile":
                let profile = self.storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
                sideMenuController?.setContentViewController(to: profile, animated: true, completion: {
                })
                sideMenuController?.hideMenu()
            case "contactUs":
                let contactUs = self.storyboard?.instantiateViewController(withIdentifier: "ContacUsVC") as! ContacUsVC
                sideMenuController?.setContentViewController(to: contactUs, animated: true, completion: {
                })
                sideMenuController?.hideMenu()
            //                self.present(contactUs, animated: true, completion: nil)
            case "aboutApp":
                let aboutApp = self.storyboard?.instantiateViewController(withIdentifier: "AboutAppVC") as! AboutAppVC
                sideMenuController?.setContentViewController(to: aboutApp, animated: true, completion: {
                })
                sideMenuController?.hideMenu()
                
            default:
                break
            }
        }else{
            let id  = cMenu[indexPath.row].id
            switch id {
            case "newOrder":
                let customerHomeVC = self.storyboard?.instantiateViewController(withIdentifier: "CustomerHomeVC")
                
                sideMenuController?.setContentViewController(to: customerHomeVC!, animated: true, completion: {
                })
                sideMenuController?.hideMenu()
            case "myProfile":
                let profile = self.storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
                sideMenuController?.setContentViewController(to: profile, animated: true, completion: {
                })
                sideMenuController?.hideMenu()
            case "contactUs":
                let contactUs = self.storyboard?.instantiateViewController(withIdentifier: "ContacUsVC") as! ContacUsVC
                sideMenuController?.setContentViewController(to: contactUs, animated: true, completion: {
                })
                sideMenuController?.hideMenu()
//                self.present(contactUs, animated: true, completion: nil)
            case "aboutApp":
                let aboutApp = self.storyboard?.instantiateViewController(withIdentifier: "AboutAppVC") as! AboutAppVC
                sideMenuController?.setContentViewController(to: aboutApp, animated: true, completion: {
               })
                sideMenuController?.hideMenu()

            default:
                break
            }
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    @IBAction func logoutBtnTapped(_ sender: Any) {
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
                let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                self.present(loginVC, animated: true, completion: nil)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    
    func observeCustomersAndDrivers() {
        
    }
    
}
