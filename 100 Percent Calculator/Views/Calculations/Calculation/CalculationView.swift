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
    
    var firstOperandString: String {
        return self.calculation.firstOperandString
    }
    var secondOperandString: String {
        return self.calculation.secondOperandString
    }

    
    @State private var operand1: String = ""
    @State private var operand2: String = ""
    @State private var calculationDone: Bool = false
    
    var body: some View {
        VStack {
            HStack{
                Text(self.userSettings.data[self.section].calculations[self.calculationIndex].title)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                Spacer()
                StarButton(section: self.section, calcIndex: self.calculationIndex, calculation: self.calculation)
                    .font(.title)
            }.padding(.horizontal)
            
            Form{
                SectionView(operand: $operand1, operandString: self.firstOperandString)
                SectionView(operand: $operand2, operandString: self.secondOperandString)
                ResultView(operand1: self.$operand1, operand2: self.$operand2, calculation: self.calculation )
                //check to see if it's time to calculate
//                checkCalculation() ?
//                    ResultView(operand1: self.$operand1, operand2: self.$operand2, calculation: self.calculation) :
//                    nil
            }
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
