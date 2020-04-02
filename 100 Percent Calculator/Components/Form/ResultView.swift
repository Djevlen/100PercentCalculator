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
    
    var body: some View {
        if(!self.operand1.isEmpty && !self.operand2.isEmpty){
            self.calculator.calculateNewPrice(operand1: self.operand1, operand2: self.operand2)
        }
        return VStack{
            HStack{
                Text(self.resultString)
                    .font(.title)
                Spacer()
                Text(self.calculator.result)
                    .font(.largeTitle)
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
}


struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(calculator: Calculator(), calculation: calculationsData[0].calculations[0], operand1: .constant("10"), operand2: .constant("10"))
    }
}
