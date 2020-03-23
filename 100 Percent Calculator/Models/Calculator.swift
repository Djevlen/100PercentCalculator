//
//  Calculator.swift
//  100 Percent Calculator
//
//  Created by Thomas Andre Johansen on 20/03/2020.
//  Copyright © 2020 Appkokeriet. All rights reserved.
//

import SwiftUI
import Combine

class Calculator: ObservableObject{
    @Published var result: String = ""
    @Published var additionalResult: String = ""
    
    
    func canCalculate(operand1: String, operand2: String) -> Bool{
        guard operand1.count > 0 && operand2.count > 0 else{
            return false
        }
        guard let _ = Double(operand1), let _ = Double(operand2) else{
                   return false
               }
        return true
    }
    
    func calculateNewPrice(operand1: String, operand2: String){
        #warning("This goes to the future 'determineFunctionCall' funcion")
        guard let operand1 = Double(operand1), let operand2 = Double(operand2) else{return}

        let result = operand1 - ((operand2/100) * operand1 )
        let additionalResult = (operand2 / 100) * operand1

        self.result = (String(format: "%.2f", result))
        self.additionalResult = (String(format: "%.2f", additionalResult))
    }
}

