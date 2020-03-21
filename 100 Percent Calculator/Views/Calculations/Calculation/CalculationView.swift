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
    @ObservedObject var calculator = Calculator(result:  "",additionalResult: "")
    
    
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
    @State private var numbersOnly = false
    @State private var missingOperand = false

    
    
    func canCalculate() -> Bool{
        print("i cancalculate")
        guard self.operand1.count > 0 && self.operand2.count > 0 else{
            return false
        }
        guard let operand1 = Double(self.operand1), let operand2 = Double(self.operand2) else{
                   numbersOnly = false
                   return false
               }
        print("result: \(self.calculator.result)")
        print("additional: \(self.calculator.additionalResult)")
        self.calculator.calculateNewPrice(operand1: operand1, operand2: operand2)
        print("result: \(self.calculator.result)")
               print("additional: \(self.calculator.additionalResult)")
        return true
    }
    
    func missingNumberError() -> Bool {
        return missingOperand
    }
    
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
                SectionView(textfieldString: $operand1, headerTitle: self.firstOperandString, withPercentage: self.calculation.placePercentagesSymbolOn.elementsEqual(self.calculation.firstOperandString))
                SectionView(textfieldString: $operand2, headerTitle: self.secondOperandString, withPercentage: self.calculation.placePercentagesSymbolOn.elementsEqual(self.calculation.secondOperandString))
                if(canCalculate()){
                    ResultView(calculation: self.calculation, result: self.calculator.result, additionalResult: self.calculator.additionalResult)
                }
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
