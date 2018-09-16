//
//  CustomerThirdPageVC.swift
//  ShipPackages
//
//  Created by Waleed Mastour on 9/10/18.
//  Copyright © 2018 Waleed Mastour. All rights reserved.
//

import UIKit
import MapKit
import Firebase
import CoreLocation
import SideMenuSwift


class CustomerThirdPageVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var pickupLocation: UITextField!
    
    @IBOutlet weak var dropoffLocation: UITextField!
    
    @IBOutlet weak var mapView: MKMapView!
    
//    var locationManager: CLLocationManager?
    var shippingInfo_  = shippingInfo()
    var ref: DatabaseReference!
    var manager: CLLocationManager?


    var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.showsUserLocation = true
        mapView.delegate = self
        
        manager = CLLocationManager()
        manager?.delegate = self
        manager?.desiredAccuracy = kCLLocationAccuracyBest
        
//        locationManager = CLLocationManager()
//        locationManager?.delegate = self
//        locationManager?.requestAlwaysAuthorization()
        pickupLocation.delegate = self
        dropoffLocation.delegate = self
//        print(shippingInfo_)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func requistBtnTapped(_ sender: Any) {
        if (pickupLocation.text?.isEmpty)! || (dropoffLocation.text?.isEmpty)! {
            displayAlertMessage(userMessage: "Pickup and drop-off locations are requierd!")
        } else {
            let user = Auth.auth().currentUser
            let uid = user?.uid
            let time = shippingInfo_.time
            let car = shippingInfo_.carType
            let desc:String = shippingInfo_.description
            let pl: String = pickupLocation.text!
            let dl: String = dropoffLocation.text!
            let customerData = ["userId": uid, "time":time ,"vehicle": car,"description": desc, "pickuplocation": pl, "dropofflocation": dl,
                                "served":"NO","assignedTo": "none"]
//            self.ref.child("orders").child(uid!).updateChildValues(customerData)
//            self.ref.child("orders").childByAutoId().setValue(customerData)
            self.displayAlertMessage(userMessage: "Your order has been added")
            let customerHomeVC = self.storyboard?.instantiateViewController(withIdentifier: "CustomerHomeVC")
            
            sideMenuController?.setContentViewController(to: customerHomeVC!, animated: true, completion: {
            })
            sideMenuController?.hideMenu()
            
        }
    }
    
    @IBAction func previousStepBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func centerMapBtnTapped(_ sender: Any) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(mapView.userLocation.coordinate, 2000 * 2.0, 2000 * 2.0 )
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func displayAlertMessage(userMessage : String) {
        let myAlert = UIAlertController(title:"Alert", message:userMessage, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler:nil)
        myAlert.addAction(OKAction)
        present(myAlert, animated: true, completion: nil)
        
    }

}

extension CustomerThirdPageVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == dropoffLocation || textField == pickupLocation {
            tableView.frame = CGRect(x: 20, y: view.frame.height, width: view.frame.width - 40, height: view.frame.height - 200)
            tableView.layer.cornerRadius = 5.0
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "locationCell")
            
            tableView.delegate = self
            tableView.dataSource = self
            
            tableView.tag = 18
            tableView.rowHeight = 60
            
            view.addSubview(tableView)
            animateTableView(shouldShow: true)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == dropoffLocation || textField == pickupLocation {
            //
            view.endEditing(true)
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
//    func textFieldShouldClear(_ textField: UITextField) -> Bool {
//        centerMapOnUserLocation()
//        return true
//    }
    
    func animateTableView(shouldShow: Bool) {
        if shouldShow {
            UIView.animate(withDuration: 0.2, animations: {
                self.tableView.frame = CGRect(x: 20, y: 365, width: self.view.frame.width - 40, height: self.view.frame.height - 450)
            })
        } else {
            UIView.animate(withDuration: 0.2, animations: {
                self.tableView.frame = CGRect(x: 20, y: self.view.frame.height, width: self.view.frame.width - 40, height: self.view.frame.height - 170)
            }, completion: { (finished) in
                for subview in self.view.subviews {
                    if subview.tag == 18 {
                        subview.removeFromSuperview()
                    }
                }
            })
        }
    }
}

extension CustomerThirdPageVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        animateTableView(shouldShow: false)
        print("Selected!")
    }
    
}

