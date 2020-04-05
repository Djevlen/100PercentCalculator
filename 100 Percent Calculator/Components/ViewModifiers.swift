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

struct LargeTitleHeader: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding(10)
        .background(Rectangle().foregroundColor(Color.init(red: 38/255.0, green: 0/255.0, blue: 255/255.0)))

    }
}

struct ModifiedRoundedRectangle: ViewModifier {
    var color: Color
    
    func body(content: Content) -> some View {
        content
            .padding(10)
            .foregroundColor(.white)
            .background(RoundedRectangle(cornerRadius: 10)
            .foregroundColor(self.color))
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

