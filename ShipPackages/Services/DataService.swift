//
//  DataService.swift
//  ShipPackages
//
//  Created by Waleed Mastour on 9/3/18.
//  Copyright © 2018 Waleed Mastour. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference()

class DataService {
    static let instance = DataService()
    
    private var _REF_BASE = DB_BASE
    private var _REF_CUSTOMER = DB_BASE.child("customers")
    private var _REF_DRIVER = DB_BASE.child("drivers")
    private var _REF_HISTORY = DB_BASE.child("history")
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    var REF_CUSTOMER: DatabaseReference {
        return _REF_CUSTOMER
    }
    var REF_DRIVER: DatabaseReference {
        return _REF_DRIVER
    }
    var REF_HISTORY: DatabaseReference {
        return _REF_HISTORY
    }
    
    func createFirebaseDBUser(uid: String, userData: Dictionary<String, Any>, isDriver: Bool) {
        if isDriver {
            REF_DRIVER.child(uid).updateChildValues(userData)
        } else {
            REF_CUSTOMER.child(uid).updateChildValues(userData)
        }
    }
}
