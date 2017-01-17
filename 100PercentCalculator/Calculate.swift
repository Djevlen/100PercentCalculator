//
//  Calculate.swift
//  Percentages
//
//  Created by Thomas Andre Johansen on 21/01/16.
//  Copyright © 2016 Appkokeriet. All rights reserved.
//

import Foundation
//this calculates all percentages for every menu option
class Calculate{
    var functionToCall: String
    init(funcToCall: String){
        self.functionToCall = funcToCall
    }
    
    func selectFunction(_ numberOne: Double, numberTwo: Double) -> (String,String){
        switch self.functionToCall{
        case "calculateNewPrice":
            return calculateNewPrice(numberOne, numberTwo: numberTwo)
        case "calculateDiscount":
            return calculateDiscount(numberOne, numberTwo: numberTwo)
        case "findPercent":
            return findPercent(numberOne, numberTwo: numberTwo)
        case "findPercentValue":
            return findPercentValue(numberOne, numberTwo: numberTwo)
        case "addPercent":
            return addPercent(numberOne, numberTwo: numberTwo)
        case "addTax":
            return addTax(numberOne, numberTwo: numberTwo)
        case "removeTax":
            return removeTax(numberOne, numberTwo: numberTwo)
        case "calculateTip":
            return calculateTip(numberOne, numberTwo: numberTwo)
        case "calculateTipReceived":
            return calculateTipReceived(numberOne, numberTwo: numberTwo)
        case "contributionMargin":
            return contributionMargin(numberOne, numberTwo:numberTwo)
        case "contributionMarginRatio":
            return contributionMarginRatio(numberOne, numberTwo: numberTwo)
            
        default:
            print("default selectFunction")
        }
        return ("Error" , "An error occured in selectFunction")
    }
    
    func calculateNewPrice(_ numberOne: Double, numberTwo: Double) -> (String, String){
        return (String(format:"%.2f",numberOne - ( (numberTwo/100) * numberOne )) , NSLocalizedString("CALCULATE_NEW_PRICE", comment: "calculateNewPrice")+String(format:"%.2f",(numberTwo/100) * numberOne))
    }
    
    func calculateDiscount(_ numberOne: Double, numberTwo: Double) -> (String, String){
        return (String(format: "%.2f%%", (1-(numberTwo/numberOne))*100) , NSLocalizedString("CALCULATE_DISCOUNT", comment: "calculateDiscount")+String(format:"%.2f",numberOne-numberTwo))
    }
    
    func findPercent(_ numberOne:Double, numberTwo:Double) -> (String, String){
        return (String(format:"%.1f%%", (numberOne / numberTwo) * 100) , "")
    }
    func findPercentValue(_ numberOne:Double, numberTwo:Double) -> (String,String){
        return (String(format:"%.2f", numberTwo/100*numberOne), "")
    }
    func addPercent(_ numberOne:Double, numberTwo:Double) -> (String, String){
        return (String(format:"%.1f%%",((numberTwo / numberOne) - 1) * 100) , "")
    }
    func addTax(_ numberOne:Double, numberTwo: Double) -> (String, String){
        return (String(format:"%.2f",numberOne * (1 + (numberTwo / 100))) , NSLocalizedString("ADD_TAX", comment: "addTax")+String(format:"%.2f",(numberOne * (1 + (numberTwo / 100))-numberOne ) ))
    }
    func removeTax(_ numberOne:Double, numberTwo: Double) -> (String, String){
        return (String(format:"%.2f",numberOne / (1 + (numberTwo / 100))) , NSLocalizedString("REMOVE_TAX", comment: "removeTax")+String(format:"%.2f",numberOne - (numberOne / (1 + (numberTwo / 100)))) )
    }
    func calculateTip(_ numberOne: Double, numberTwo: Double) -> (String, String) {
        return (String(format:"%.2f",(numberOne+(numberTwo/100)*numberOne)-numberOne) , NSLocalizedString("CALCULATE_TIP", comment: "calculateTip")+String(format:"%.2f",numberOne+(numberTwo/100)*numberOne))
    }
    func calculateTipReceived(_ numberOne: Double, numberTwo: Double) -> (String, String) {
        let difference = numberTwo - numberOne
        return (String(format:"%.2f%%",(difference / numberOne) * 100) , NSLocalizedString("CALCULATE_TIP_RECEIVED", comment: "calculateTipReceived")+String(format:"%.2f",difference))
    }
    func contributionMargin(_ numberOne:Double, numberTwo: Double) -> (String, String){
        return (String(format:"%.2f%", numberTwo-numberOne ) , NSLocalizedString("CONTRIBUTION_MARGIN_RESULT_SUBTITLE", comment: "contributionMarginResultSubtitle")+String(format:"%.2f%%",((numberTwo - numberOne)/numberTwo)*100))
    }
    func contributionMarginRatio(_ numberOne:Double, numberTwo:Double) -> (String, String){
        let price = numberTwo * (1 + (numberOne / 100))
        return (String(format:"%.2f%",(numberTwo+(price-numberTwo))), NSLocalizedString("CONTRIBUTION_MARGIN_RATIO_RESULT_SUBTITLE", comment: "contributionMarginResultSubtitle")+String(format:"%.2f%", price - numberTwo ) )
    }
}
