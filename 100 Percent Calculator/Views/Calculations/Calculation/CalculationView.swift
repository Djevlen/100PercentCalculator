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
        return self.calculation.firstOperandString
    }
    var secondOperandString: String {
        return self.calculation.secondOperandString
    }
    
    @State private var operand1: String = ""
    @State private var operand2: String = ""
    @State private var isCalculating: Bool = false
    
    
    var body: some View {
//        ScrollView{
            ZStack{
                VStack {
                    HStack{
                        Text(self.calculation.title)
                            .fontWeight(.heavy)
                        Spacer()
                        StarButton(calculation: self.calculation)                        
                    }.modifier(LargeTitleHeader())
                    VStack{
                        VStack {
                            SectionView(textfieldString: $operand1, calculation: self.calculation, placeholder: self.firstOperandString)
                                .onAppear{
                                    self.operand1 = self.calculation.defaultOperand1 ?? ""
                            }
                            SectionView(textfieldString: $operand2, calculation: self.calculation, placeholder: self.secondOperandString)
                                .onAppear{
                                    self.operand2 = self.calculation.defaultOperand2 ?? ""
                            }
                        }.modifier(SectionViewGroup())
                        ResultView(calculator:self.calculator, calculation: self.calculation, operand1: self.$operand1, operand2: self.$operand2)
                            .modifier(LargeTitleHeader(radius: 5))
                            .padding(.horizontal, 5)
                            .onReceive(self.calculator.$isCalculating, perform: { (bool) in
                                self.isCalculating = bool
                            })
                            .opacity(self.isCalculating ? 1 : 0)
                    }
                    Spacer()
                }
                VStack(alignment: .trailing){
                    KeyboardButtonRow(calculator: self.calculator)
                }
        }
            
    }
//    }
    
}

struct CalculationView_Previews: PreviewProvider {
    static var previews: some View {
        CalculationView(calculation: calculationsData[0].calculations[0]).environmentObject(KeyboardController())
    }
}
