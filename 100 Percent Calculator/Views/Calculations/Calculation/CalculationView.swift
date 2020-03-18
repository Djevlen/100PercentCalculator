//
//  CalculationView.swift
//  100 Percent Calculator
//
//  Created by Thomas Andre Johansen on 18/03/2020.
//  Copyright © 2020 Appkokeriet. All rights reserved.
//

import SwiftUI

struct CalculationView: View {
    @EnvironmentObject private var userSettings: UserSettings
    var calculation: Calculation
    var section: Int

    var calculationIndex: Int {
        userSettings.data[section].calculations.firstIndex(where: { $0.id == calculation.id })!
    }
    
    var body: some View {
        VStack {
            Button(action: {self.userSettings.toggleFavorite(section: self.section, calculationIndex: self.calculationIndex, calculation: self.calculation)}){
                Image(systemName: self.userSettings.data[self.section].calculations[self.calculationIndex].isFavorite ? "star.fill" : "star")
                .foregroundColor(.yellow)
            }
            .font(.title)
            Text(self.userSettings.data[self.section].calculations[self.calculationIndex].title)
            .font(.largeTitle)
            Text(self.userSettings.data[self.section].calculations[self.calculationIndex].firstOperandString)
            Text(self.userSettings.data[self.section].calculations[self.calculationIndex].secondOperandString)
        }
        .font(.title)
    }
}

struct CalculationView_Previews: PreviewProvider {
    static var previews: some View {
        let userSettings = UserSettings(data:  calculationsData, favoriteCalculations: [Calculation](), startingTab: "Favorites")
        return CalculationView(calculation: userSettings.data[0].calculations[0], section: 0).environmentObject(userSettings)
    }
}
