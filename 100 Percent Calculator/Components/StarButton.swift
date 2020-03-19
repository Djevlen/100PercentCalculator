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
    var section: Int
    var calcIndex: Int
    var calculation: Calculation
    
    var body: some View {
        Button(action: {self.userSettings.toggleFavorite(section: self.section, calculationIndex: self.calcIndex, calculation: self.calculation)}){
        Image(systemName: self.userSettings.data[self.section].calculations[self.calcIndex].isFavorite ? "star.fill" : "star")
        .foregroundColor(.yellow)
    }
    }
}

struct StarButton_Previews: PreviewProvider {
    static var previews: some View {
        StarButton(section: 0, calcIndex: 0, calculation: calculationsData[0].calculations[0]).environmentObject(UserSettings(data: calculationsData, favoriteCalculations: [Calculation](), startingTab: "lol"))
    }
}
