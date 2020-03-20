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
    var result: String
    var additionalResult: String

    init(result: String, additionalResult: String) {
        self.result = result
        self.additionalResult = additionalResult
    }

    func calculateNewPrice(operand1: Double, operand2: Double){
        let result = operand1 - ((operand2/100) * operand1 )
        let additionalResult = (operand2 / 100) * operand1

        self.result = (String(format: "%.2f", result))
        self.additionalResult = (String(format: "%.2f", additionalResult))
    }
}

