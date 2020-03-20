//
//  Calculator.swift
//  100 Percent Calculator
//
//  Created by Thomas Andre Johansen on 20/03/2020.
//  Copyright © 2020 Appkokeriet. All rights reserved.
//


import Foundation
import SwiftUI
import Combine

class Calculator: ObservableObject{
    @Published var result: String
    @Published var additionalResult: String


    init(result: String, additionalResult: String) {
        self.result = result
        self.additionalResult = additionalResult
    }

    func calculateNewPrice2(operand1: Double, operand2: Double){
        let result = operand1 - ((operand2/100) * operand1 )
        let additionalResult = (operand2 / 100) * operand1

        self.result = (String(format: "%.2f", result))
        self.additionalResult = (String(format: "%.2f", additionalResult))
    }
//
//    func calculateNewPrice(_ numberOne: Double, numberTwo: Double) -> (String, String){
//
//        return (String(format:"%.2f",numberOne - ( (numberTwo/100) * numberOne )) , NSLocalizedString("CALCULATE_NEW_PRICE", comment: "calculateNewPrice")+String(format:"%.2f",(numberTwo/100) * numberOne))
//    }
}

