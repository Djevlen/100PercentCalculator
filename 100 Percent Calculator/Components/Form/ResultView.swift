//
//  NewResult.swift
//  100 Percent Calculator
//
//  Created by Thomas Andre Johansen on 22/03/2020.
//  Copyright © 2020 Appkokeriet. All rights reserved.
//

import SwiftUI

struct ResultView: View {
    var calculator: Calculator
    var calculation: Calculation
    @Binding var operand1: String
    @Binding var operand2: String
    var compactMode: Bool = false
    @State private var resultCopiedOpacity: Double  = 0.0
    @State private var calculatorResult: String = ""
    
    var resultString: String {
        self.calculation.resultString
    }
    
    var additionalResultString: String {
        if let flavorString = self.calculation.additionalString{
            return flavorString
        }else{
            return ""
        }
    }
    
    var withPercentage: Bool {
        return self.calculation.placePercentagesSymbolOn.elementsEqual(self.resultString)
    }
    
    var body: some View {
        if (self.calculator.canCalculate(operand1: self.operand1, operand2: self.operand2)){
            self.calculator.performCalculation(calcToPerform: self.calculation.calcToPerform, operand1: self.operand1, operand2: self.operand2)
        }
        
        return ZStack{
            VStack{
            if self.calculator.isCalculating {
                if (!compactMode){
                    HStack{
                        Text(self.resultString)
                            .font(.title)
                            .underline(true, color: .underline)
                        Spacer()
                    }
                }
                HStack{
                    if (!compactMode){
                        Spacer()
                    }else{
                        Text(self.resultString)
                        .font(.subheadline)
                            .underline(true, color: .underline)
                        Spacer()
                    }
                    Text(self.calculator.result)
                        .font(.largeTitle)
                    .underline(true, color: .underline)

                    self.withPercentage ? Text("%").font(.largeTitle) : nil
                }
                if(self.additionalResultString.count > 0){
                    HStack{
                        Spacer()
                        Text(self.additionalResultString + " " + self.calculator.additionalResult)
                            .font(.subheadline)
                    }
                }
                }
                
            }
            if self.resultCopiedOpacity > 0{
                           HStack{
                               Spacer()
                               Text(self.calculatorResult)
                                .font(self.compactMode ? .title : .largeTitle)
                               .modifier(ModifiedRoundedRectangle(color: .green))
                               .opacity(self.resultCopiedOpacity)
                               Spacer()
                           }
                       }
        }.onTapGesture {
            self.copyResult()
        }
    }
    
    func copyResult(){
        if self.calculator.result.count > 0{
            self.resultCopiedOpacity = 1
            self.calculatorResult = self.calculator.copyResult()
            withAnimation(Animation.easeOut(duration: 1.5)){
                self.resultCopiedOpacity = 0
                self.calculatorResult = ""
            }
        }
    }
}


struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(calculator: Calculator(), calculation: calculationsData[0].calculations[0], operand1: .constant("10"), operand2: .constant("10"))
    }
}
