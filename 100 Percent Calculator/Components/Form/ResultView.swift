//
//  ResultView.swift
//  100 Percent Calculator
//
//  Created by Thomas Andre Johansen on 19/03/2020.
//  Copyright © 2020 Appkokeriet. All rights reserved.
//

import SwiftUI

struct ResultView: View{
    var calculation: Calculation
    var result: String
    var additionalResult: String
    
    var resultString: String {
        return self.calculation.resultString
    }
    private var bindableResult: Binding<String> { Binding (
        get: { self.currencyFormatted(input: self.result) },
        set: { _ in }
        )
    }
    var additionalString: String {
        return self.calculation.additionalString
    }
    func currencyFormatted(input: String) -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current

        #warning("sjekk ut om dette kan gjøres penere")
        // We'll force unwrap with the !, if you've got defined data you may need more error checking
        let priceString = currencyFormatter.string(from: Double(input)! as NSNumber)
        return priceString!
        
    }
    
    
    var body: some View{
        Group{
            SectionView(textfieldString: self.bindableResult, headerTitle: self.resultString, textFieldDisabled: true, footer: self.additionalString + self.additionalResult)
        }
    }
}

//struct ResultView_Previews: PreviewProvider {
//    static var previews: some View {
//        ResultView(calculation: calculationsData[0].calculations[0], result: "10", additionalResult: "10")
//    }
//}
