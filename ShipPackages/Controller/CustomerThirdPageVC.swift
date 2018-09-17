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


class CustomerThirdPageVC: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var pickupLocation: UITextField!
    
    @IBOutlet weak var dropoffLocation: UITextField!
    
    @IBOutlet weak var mapView: MKMapView!
    
    var driverList = [String]()
    
//    var locationManager: CLLocationManager?
    var shippingInfo_  = shippingInfo()
    var ref: DatabaseReference!
    var manager: CLLocationManager?


    var tableView = UITableView()
    var matchingItems: [MKMapItem] = [MKMapItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.showsUserLocation = true
        mapView.delegate = self
        
        manager = CLLocationManager()
        manager?.delegate = self
        manager?.requestAlwaysAuthorization()
        manager?.desiredAccuracy = kCLLocationAccuracyBest
        
        ref = Database.database().reference()
        let query = self.ref.child("drivers").queryOrdered(byChild: "userIsDriver").queryEqual(toValue: "true")
        query.observe(.value) { (snapshot) in
            for child in snapshot.children.allObjects as! [DataSnapshot]{
                let dict = child.value as? [String: AnyObject] ?? [:]
                self.driverList.append(dict["firstName"] as! String)
            }
        }
        
//        locationManager = CLLocationManager()
//        locationManager?.delegate = self
//        locationManager?.requestAlwaysAuthorization()
//        pickupLocation.delegate = self
//        dropoffLocation.delegate = self
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
            self.ref.child("orders").childByAutoId().setValue(customerData)
            self.displayAlertMessage(userMessage: "Your order has been added")
            let customerHomeVC = self.storyboard?.instantiateViewController(withIdentifier: "CustomerHomeVC")
            
            sideMenuController?.setContentViewController(to: customerHomeVC!, animated: true, completion: {
            })
            sideMenuController?.hideMenu()
            
        }
    }
    func centerMapOnUserLocation(){
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(mapView.userLocation.coordinate, 2000 * 2.0, 2000 * 2.0 )
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    @IBAction func previousStepBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func centerMapBtnTapped(_ sender: Any) {
        centerMapOnUserLocation()
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
             performSearch()
            view.endEditing(true)
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        matchingItems = []
        tableView.reloadData()
        centerMapOnUserLocation()
        return true
    }
    
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

extension CustomerThirdPageVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        UpdateService.instance.updateUserLocation(withCoordinate: userLocation.coordinate)
        UpdateService.instance.updateDriverLocation(withCoordinate: userLocation.coordinate)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? DriverAnnotation {
            let identifier = "driver"
            var view: MKAnnotationView
            view = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.image = UIImage(named: "driverAnnotation")
            return view
        }
        return nil
    }
    
    //    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
    //        centerMapBtn.fadeTo(alphaValue: 1.0, withDuration: 0.2)
    //    }
    
    func performSearch() {
        matchingItems.removeAll()
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = dropoffLocation.text
        request.region = mapView.region
        
        let search = MKLocalSearch(request: request)
        
        search.start { (response, error) in
            if error != nil {
                print(error.debugDescription)
                //                self.showAlert(error.debugDescription)
            } else if response!.mapItems.count == 0 {
                print("No result!")
                //                self.showAlert(ERROR_MSG_NO_MATCHES_FOUND)
            } else {
                for mapItem in response!.mapItems {
                    self.matchingItems.append(mapItem as MKMapItem)
                    self.tableView.reloadData()
                    //                    self.shouldPresentLoadingView(false)
                }
            }
        }
        request.naturalLanguageQuery = pickupLocation.text
        request.region = mapView.region
        
        //        let search = MKLocalSearch(request: request)
        
        search.start { (response, error) in
            if error != nil {
                print(error.debugDescription)
                //                self.showAlert(error.debugDescription)
            } else if response!.mapItems.count == 0 {
                print("No result!")
                //                self.showAlert(ERROR_MSG_NO_MATCHES_FOUND)
            } else {
                for mapItem in response!.mapItems {
                    self.matchingItems.append(mapItem as MKMapItem)
                    self.tableView.reloadData()
                    //                    self.shouldPresentLoadingView(false)
                }
            }
        }
    }
    
}


extension CustomerThirdPageVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "locationCell ")
        let mapItem = matchingItems[indexPath.row]
        cell.textLabel?.text = mapItem.name
        cell.detailTextLabel?.text = mapItem.placemark.title
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        animateTableView(shouldShow: false)
//        self.pickupLocation.text
        print("Selected!")
    }
    
}

