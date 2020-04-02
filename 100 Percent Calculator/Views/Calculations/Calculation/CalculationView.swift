//
//  CalculationView.swift
//  100 Percent Calculator
//
//  Created by Thomas Andre Johansen on 18/03/2020.
//  Copyright © 2020 Appkokeriet. All rights reserved.
//

import SwiftUI

struct CalculationView: View {
    @EnvironmentObject var keyboard: KeyboardController
    @ObservedObject var calculator: Calculator = Calculator()
    var calculation: Calculation
    
    var firstOperandString: String {
        print("default first: \(String(describing: self.calculation.defaultOperand1))")
        return self.calculation.firstOperandString
    }
    var secondOperandString: String {
        print("default second: \(String(describing: self.calculation.defaultOperand2))")
        
        return self.calculation.secondOperandString
    }
    
    @State private var operand1: String = ""
    @State private var operand2: String = ""
    
    
    var body: some View {
            VStack {
                HStack{
                    Text(self.calculation.title)
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                    Spacer()
                    StarButton(calculation: self.calculation)
                        .font(.largeTitle)
                }
                VStack{
                    SectionView(textfieldString: $operand1, calculation: self.calculation, placeholder: self.firstOperandString)
                    SectionView(textfieldString: $operand2, calculation: self.calculation, placeholder: self.secondOperandString)
                    if(self.calculator.canCalculate(operand1: operand1, operand2: operand2)){
                        ResultView(calculation: calculation, operand1: self.$operand1, operand2: self.$operand2, calculator: self.calculator)
                    }
                }
                VStack(alignment: .trailing){
                    Spacer()
                    HStack{
                        Spacer()
                        KeyboardButtonRow(calculator: self.calculator)
                    }
                    
                }
            }
            .font(.title)
            .padding(.horizontal)
    }
    
}

struct CalculationView_Previews: PreviewProvider {
    static var previews: some View {
        let calculator = Calculator()
        return CalculationView(calculation: calculationsData[0].calculations[0]).environmentObject(calculator)
    }
}
