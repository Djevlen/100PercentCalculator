//
//  CalculationView.swift
//  100 Percent Calculator
//
//  Created by Thomas Andre Johansen on 18/03/2020.
//  Copyright © 2020 Appkokeriet. All rights reserved.
//

import SwiftUI

struct CalculationView: View {
    @Environment(\.editMode) var mode
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
    
    var body: some View {
        NavigationView {
            if self.mode?.wrappedValue == .inactive {
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
                
            } else {
                EditDefaultsView(calculation: self.calculation)
            }
            

        }
        .font(.title)
        .navigationBarTitle(Text(self.calculation.title), displayMode: .inline)
        .navigationBarItems(trailing: EditButton())
        .padding(.horizontal)
        
    }
}

struct CalculationView_Previews: PreviewProvider {
    static var previews: some View {
        let userSettings = UserSettings(data:  calculationsData, favoriteCalculations: [Calculation](), startingTab: "Favorites")
        let calculator = Calculator()
        return CalculationView(calculation: userSettings.data[0].calculations[0], section: 0).environmentObject(userSettings).environmentObject(calculator)
    }
}
