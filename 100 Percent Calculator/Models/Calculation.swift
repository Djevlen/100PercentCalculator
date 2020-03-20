//
//  Calculation.swift
//  100 Percent Calculator
//
//  Created by Thomas Andre Johansen on 17/03/2020.
//  Copyright © 2020 Appkokeriet. All rights reserved.
//

/*
 The model for an individual calculation
 */

import SwiftUI

struct Calculation: Hashable, Codable, Identifiable {
    var id: Int
    var title: String
    var firstOperandString: String
    var secondOperandString: String
    var resultString: String
    var additionalString: String
    var showCurrencySymbol: Bool
    var placePercentagesSymbolOn: String
    var defaultValue1: Double?
    var defaultValue2: Double?
    var isFavorite: Bool
    var isHidden: Bool
    
    func calculateNewPrice(_ numberOne: Double, numberTwo: Double) -> (String, String){
        return (String(format:"%.2f",numberOne - ( (numberTwo/100) * numberOne )) , NSLocalizedString("CALCULATE_NEW_PRICE", comment: "calculateNewPrice")+String(format:"%.2f",(numberTwo/100) * numberOne))
    }

}

/*
 The model for calculation categories
 */
struct CalculationCategory: Hashable, Codable, Identifiable {
    var id: Int
    var title: String
    var isFavorite: Bool
    var isHidden: Bool
    var calculations: [Calculation]
    
}
