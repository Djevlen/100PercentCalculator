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
    @Published var isCalculating: Bool = false
    
    
    func canCalculate(operand1: String, operand2: String) -> Bool{
        guard operand1.count > 0 && operand2.count > 0 else{
            self.result = ""
            self.additionalResult = ""
            self.isCalculating = false
            return false
        }
        guard let _ = Double(operand1.replacingOccurrences(of: ",", with: ".")), let _ = Double(operand2.replacingOccurrences(of: ",", with: ".")) else{
            self.result = ""
            self.additionalResult = ""
            self.isCalculating = false
            return false
        }
        return true
    }
    
    func setResultInLocale(result: Double, additionalResult: Double){
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = .current
        numberFormatter.numberStyle = .decimal
        
        if let res = numberFormatter.string(from: NSNumber(value: result)){
            self.result = res
        }
        if let addRes = numberFormatter.string(from: NSNumber(value: additionalResult)){
            self.additionalResult = addRes
        }
    }
    
    func performCalculation(calcToPerform: String, operand1: String, operand2: String){
        switch calcToPerform {
        case "CalculateNewPrice":
            calculateNewPrice(operand1: operand1, operand2: operand2)
        default:
            print("dette er defauuuulu!")
        }
        
    }
    
    func calculateNewPrice(operand1: String, operand2: String){
        #warning("This goes to the future 'determineFunctionCall' funcion")
        let dotOperand1 = operand1.replacingOccurrences(of: ",", with: ".")
        let dotOperand2 = operand2.replacingOccurrences(of: ",", with: ".")
        guard let operand1 = Double(dotOperand1), let operand2 = Double(dotOperand2) else{
            self.isCalculating = false
            return
        }
        self.isCalculating = true
        
        let result = operand1 - ((operand2/100) * operand1 )
        let additionalResult = (operand2 / 100) * operand1
        
        self.setResultInLocale(result: result, additionalResult: additionalResult)
    }
}
