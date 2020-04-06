//
//  HostingController.swift
//  100 Percent Calculator
//
//  Created by Thomas Andre Johansen on 06/04/2020.
//  Copyright © 2020 Appkokeriet. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

class HostingController: UIHostingController<ContentView> {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
