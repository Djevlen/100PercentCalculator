//
//  AboutView.swift
//  100 Percent Calculator
//
//  Created by Thomas Andre Johansen on 26/03/2020.
//  Copyright © 2020 Appkokeriet. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack(alignment: .leading){
            Text("Hi! 👋")
                .font(.largeTitle)
            Text("I'm Thomas. I made this app with the help of my dotted friend Dent.")
                .font(.headline)
            Image(systemName: "person")
            Text("Thank you for downloading it - I hope it helps you out! 😊")
            Text("")
            Text("I (try to) make a living by making apps, and I decided to remove all ads from 100%, so I'd be really thankful if you'd consider buying PRO, giving me a tip, or maybe leaving a positive review by pressing the button below.")
                .font(.body)
            Text("")
            Text("- Thomas ❤️")
                .font(.caption)
            Spacer()
        }
        
        
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
