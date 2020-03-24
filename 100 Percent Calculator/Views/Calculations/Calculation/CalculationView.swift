//
//  CalculationView.swift
//  100 Percent Calculator
//
//  Created by Thomas Andre Johansen on 18/03/2020.
//  Copyright © 2020 Appkokeriet. All rights reserved.
//

import SwiftUI

struct CalculationView: View {
    @EnvironmentObject var userSettings: UserSettings
    @ObservedObject var calculator: Calculator = Calculator()
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
    
    
    func canCalculate() -> Bool{
        guard self.operand1.count > 0 && self.operand2.count > 0 else{
            return false
        }
        guard let _ = Double(self.operand1), let _ = Double(self.operand2) else{
            return false
        }
        return true
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack{
                    Text(self.userSettings.data[self.section].calculations[self.calculationIndex].title)
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                    Spacer()
                    StarButton(calculation: self.calculation)
                        .font(.largeTitle)
                }
                Group{
                    SectionView(textfieldString: $operand1, calculation: self.calculation, placeholder: self.firstOperandString)
                    SectionView(textfieldString: $operand2, calculation: self.calculation, placeholder: self.secondOperandString)
                    if(self.calculator.canCalculate(operand1: self.operand1, operand2: self.operand2)){
                        ResultView(calculation: self.calculation, operand1: self.$operand1, operand2: self.$operand2)
                    }
                }
            }
            .font(.title)
            .navigationBarTitle(Text(self.calculation.title), displayMode: .inline)
            .padding(.horizontal)

        }

        
    }
}

struct CalculationView_Previews: PreviewProvider {
    static var previews: some View {
        let userSettings = UserSettings(data:  calculationsData, favoriteCalculations: [Calculation](), startingTab: "Favorites")
        let calculator = Calculator()
        return CalculationView(calculation: userSettings.data[0].calculations[0], section: 0).environmentObject(userSettings).environmentObject(calculator)
    }
}
