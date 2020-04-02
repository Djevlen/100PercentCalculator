//
//  ViewExtensions.swift
//  100 Percent Calculator
//
//  Created by Thomas Andre Johansen on 01/04/2020.
//  Copyright © 2020 Appkokeriet. All rights reserved.
//

import SwiftUI


//any view can call dismissKeyboard
extension View {
    func dismissKeyboard(){
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.endEditing(true)
    }
}
