//
//  CenterVCDelegate.swift
//  ShipPackages
//
//  Created by Waleed Mastour on 9/2/18.
//  Copyright © 2018 Waleed Mastour. All rights reserved.
//

import UIKit

protocol CenterVCDelegate {
    func toggleLeftPanel()
    func addLeftPanelViewController()
    func animateLeftPanel(shouldExpand: Bool)
}
