//
//  ViewModifiers.swift
//  100 Percent Calculator
//
//  Created by Thomas Andre Johansen on 30/03/2020.
//  Copyright © 2020 Appkokeriet. All rights reserved.
//

import SwiftUI

struct KeyboardButton: ViewModifier {
    func body(content: Content) -> some View {
        content
        .frame(width: 100, height: 110)
        .foregroundColor(.white)
        .background(RoundedRectangle(cornerRadius: 10)
        .foregroundColor(.blue))
        .shadow(radius: 5)
        
    }
}

struct GreenRoundedRectangle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(10)
            .foregroundColor(.white)
            .background(RoundedRectangle(cornerRadius: 10)
            .foregroundColor(.green))
            .shadow(radius: 5)
    }
}
//Card shape
struct Card: ViewModifier {
    var width: CGFloat
    var height: CGFloat
    
    func body(content: Content) -> some View {
        content
            .frame(width: self.width, height: self.height)
            .foregroundColor(.white)
            .background(RoundedRectangle(cornerRadius: 10)
            .foregroundColor(.blue))
            .shadow(radius: 5)
    }
}

