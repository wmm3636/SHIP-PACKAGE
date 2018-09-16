//
//  UIVIewController.swift
//  ShipPackages
//
//  Created by Waleed Mastour on 9/12/18.
//  Copyright © 2018 Waleed Mastour. All rights reserved.
//

import UIKit
import SideMenuSwift
public extension UIViewController {
    
    /// Access the nearest ancestor view controller  hierarchy that is a side menu controller.
    public var sideMenuController: SideMenuController? {
        print(self)
        return findSideMenuController(from: self)
    }
    
     func findSideMenuController(from viewController: UIViewController) -> SideMenuController? {
        var sourceViewController: UIViewController? = viewController
        repeat {
            sourceViewController = sourceViewController?.parent
            if let sideMenuController = sourceViewController as? SideMenuController {
                return sideMenuController
            }
        } while (sourceViewController != nil)
        return nil
    }
}

public extension UIViewController
{
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}
