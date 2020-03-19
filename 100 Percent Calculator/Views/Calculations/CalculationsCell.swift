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
            Spacer()
            StarButton(section: self.section, calcIndex: self.calculationIndex, calculation: self.calculation)
            .font(.title)
            
            Text(calculation.title)
                .font(.body)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
