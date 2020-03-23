//
//  NoFavoritesView.swift
//  100 Percent Calculator
//
//  Created by Thomas Andre Johansen on 23/03/2020.
//  Copyright © 2020 Appkokeriet. All rights reserved.
//

import SwiftUI

struct NoFavoritesView: View {
    var body: some View {
        VStack(alignment: .center){
            Image(systemName: "star")
                .font(.largeTitle)
                .foregroundColor(.yellow)
            Text("You have no favorites.")
            Text("When you add favorites you will find them here.")
                .multilineTextAlignment(.center)

        }
    .padding()
    }
}

struct NoFavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        NoFavoritesView()
    }
}
