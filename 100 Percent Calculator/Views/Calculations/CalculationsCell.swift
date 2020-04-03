//
//  CalculationsCell.swift
//  100 Percent Calculator
//
//  Created by Thomas Andre Johansen on 17/03/2020.
//  Copyright © 2020 Appkokeriet. All rights reserved.
//

import SwiftUI

struct CalculationsCell: View {
    var calculation: Calculation

    var body: some View {
        HStack {
            StarButton(calculation: self.calculation)
                .font(.title)
            Text(calculation.title)
                .font(.body)
        }
    }
}
