//
//  NoFavoritesView.swift
//  100 Percent Calculator
//
//  Created by Thomas Andre Johansen on 23/03/2020.
//  Copyright © 2020 Appkokeriet. All rights reserved.
//

import SwiftUI

struct NoFavoritesView: View {
    @State private var starBounce: CGFloat = 1.0
    
    var body: some View {
        VStack(){
            Image(systemName: "star.fill")
                .font(.largeTitle)
                .foregroundColor(.yellow)
                .scaleEffect(starBounce)
                .animation(Animation.easeInOut(duration: 3).repeatForever())
                .padding()
                .shadow(radius: 5)
            Text("You have no favorites.")
            Text("When you add favorites you will find them here.")
        }
        .padding()
        .onAppear{
            self.starBounce = 1.5
        }
        .onDisappear{
            self.starBounce = 1.0
        }
    }
}

struct NoFavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        NoFavoritesView()
    }
}
