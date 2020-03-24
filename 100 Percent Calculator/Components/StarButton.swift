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
        Image(systemName: self.calculation.isFavorite ? "star.fill" : "star")
            .resizable()
            .frame(width: 50, height: 50, alignment: .trailing)
            .foregroundColor(.yellow)
            .onTapGesture {
                self.userSettings.toggleFavoriteFromCalculation(calculation: self.calculation)
            }
    }
}

struct StarButton_Previews: PreviewProvider {
    static var previews: some View {
        StarButton(calculation: calculationsData[0].calculations[0]).environmentObject(UserSettings(data: calculationsData, favoriteCalculations: [Calculation](), startingTab: "lol"))
    }
}
