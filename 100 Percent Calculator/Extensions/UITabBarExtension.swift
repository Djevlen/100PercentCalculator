//
//  UITabBarExtension.swift
//  100 Percent Calculator
//
//  Created by Thomas Andre Johansen on 05/04/2020.
//  Copyright © 2020 Appkokeriet. All rights reserved.
//

import Foundation
import UIKit

//extension to configure appearance
extension UITabBarController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        let standardAppearance = UITabBarAppearance()
        
        
        // update the appearance
        
        
        tabBar.standardAppearance = standardAppearance
    }
}
