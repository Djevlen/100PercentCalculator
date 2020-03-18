//
//  CalculationsCell.swift
//  100 Percent Calculator
//
//  Created by Thomas Andre Johansen on 17/03/2020.
//  Copyright © 2020 Appkokeriet. All rights reserved.
//

import SwiftUI

struct CalculationsCell: View {
    @EnvironmentObject private var userSettings: UserSettings
    var calculation: Calculation
    var section: Int

    var calculationIndex: Int {
        userSettings.data[section].calculations.firstIndex(where: { $0.id == calculation.id })!
    }
    var body: some View {
        HStack {
            Button(action: {self.userSettings.toggleFavorite(section: self.section, calculationIndex: self.calculationIndex, calculation: self.calculation)}){
                Image(systemName: self.userSettings.data[self.section].calculations[self.calculationIndex].isFavorite ? "star.fill" : "star")
                .foregroundColor(.yellow)
            }
            .font(.title)
            
            Text(calculation.title)
                .font(.body)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
