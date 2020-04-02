//
//  StarButton.swift
//  100 Percent Calculator
//
//  Created by Thomas Andre Johansen on 19/03/2020.
//  Copyright © 2020 Appkokeriet. All rights reserved.
//

import SwiftUI

struct StarButton: View {
    @EnvironmentObject var userSettings: UserSettings
    var calculation: Calculation
    
    var body: some View {
        Button(action: {
            self.userSettings.toggleFavorite(calculation: self.calculation)
        }){
            Image(systemName: self.calculation.isFavorite ? "star.fill" : "star")
                .foregroundColor(.yellow)
        }
        .buttonStyle(BorderlessButtonStyle())
        .alert(isPresented: self.$userSettings.favoriteLimitReached) {
            Alert(title: Text("100% Pro Needed"), message: Text("Buy Pro to get unlimited favorites!"), dismissButton: .default(Text("Ok!")))
        }
    }
}


struct StarButton_Previews: PreviewProvider {
    static var previews: some View {
        StarButton(calculation: calculationsData[0].calculations[0]).environmentObject(UserSettings(data: calculationsData, favoriteCalculations: [Calculation]()))
    }
}
