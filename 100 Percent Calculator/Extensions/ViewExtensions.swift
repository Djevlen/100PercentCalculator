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
    //dismisses the keyboard by endEditing
    func dismissKeyboard(){
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.endEditing(true)
    }
    
    //gets the insets from top and bottom and returns the sum
    func getSafeAreaInsets() -> CGFloat{
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let topPadding = window?.safeAreaInsets.top ?? 0
        let bottomPadding = window?.safeAreaInsets.bottom ?? 0

        return bottomPadding + topPadding
    }
}

