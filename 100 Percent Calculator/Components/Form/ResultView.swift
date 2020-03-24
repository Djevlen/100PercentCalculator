//
//  NewResult.swift
//  100 Percent Calculator
//
//  Created by Thomas Andre Johansen on 22/03/2020.
//  Copyright © 2020 Appkokeriet. All rights reserved.
//

import SwiftUI

struct ResultView: View {
    @ObservedObject var calculator: Calculator = Calculator()
    var calculation: Calculation
    @Binding var operand1: String
    @Binding var operand2: String
    
    var resultString: String {
        return self.calculation.resultString
    }
    var additionalString: String {
        return self.calculation.additionalString
    }
    private var bindableResult: Binding<String> { Binding (
        get: {  self.calculator.result },
        set: { _ in }
        )
    }

    init(calculation: Calculation, operand1: Binding<String>, operand2: Binding<String>) {
        self.calculation = calculation
        self._operand1 = operand1
        self._operand2 = operand2
        self.calculator.calculateNewPrice(operand1: self.operand1, operand2: self.operand2)
    }
    
    var body: some View {
        Group{
            SectionView(textfieldString: self.bindableResult, header: self.resultString, textFieldDisabled: true, footer: self.additionalString + " " + self.calculator.additionalResult, calculation: self.calculation, placeholder: self.resultString)
            ButtonRow(calculation: self.calculation, operand1: self.$operand1, operand2: self.$operand2, result: self.bindableResult)
        }
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(calculation: calculationsData[0].calculations[0], operand1: .constant("10"), operand2: .constant("10"))
    }
}
