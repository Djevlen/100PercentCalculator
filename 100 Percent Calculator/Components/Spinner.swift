//
//  Spinner.swift
//  100 Percent Calculator
//
//  Created by Thomas Andre Johansen on 08/04/2020.
//  Copyright © 2020 Appkokeriet. All rights reserved.
//

import SwiftUI

struct Spinner: View {
    @State private var animationAngle:Double = 0.0
    var body: some View {
        VStack(alignment: .center){
            Image(systemName: "arrow.clockwise.circle")
                .rotationEffect(.degrees(self.animationAngle))
                .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: false))
        }
        .onAppear{
            self.animationAngle = 360
        }
        .font(.largeTitle)
        //.modifier(Card(width: 150, height: 150))
        .padding()
    }
}

struct Spinner_Previews: PreviewProvider {
    static var previews: some View {
        Spinner()
    }
}
