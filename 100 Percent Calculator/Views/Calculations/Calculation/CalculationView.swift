//
//  CalculationView.swift
//  100 Percent Calculator
//
//  Created by Thomas Andre Johansen on 18/03/2020.
//  Copyright © 2020 Appkokeriet. All rights reserved.
//

import SwiftUI

struct CalculationView: View {
    let calculation: Calculation
//    let header: String
//    let firstOperand: String
//    let secondOperand: String
    
    var body: some View {
        VStack {
            Text(calculation.title)
            .font(.largeTitle)
            Text(calculation.firstOperandString)
            Text(calculation.secondOperandString)
        }
        .font(.title)
    }
}

struct CalculationView_Previews: PreviewProvider {
    static var previews: some View {
        CalculationView(calculation: calculationsData[0].calculations[0])
    }
}
