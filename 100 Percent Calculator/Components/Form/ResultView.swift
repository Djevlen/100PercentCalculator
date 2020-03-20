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
        get: { self.result },
        set: { _ in }
        )
    }
    var additionalString: String {
        return self.calculation.additionalString
    }
    
    
    var body: some View{
        Group{
            SectionView(textfieldString: self.bindableResult, headerTitle: self.resultString, textFieldDisabled: true, footer: self.additionalString + self.additionalResult)
        }
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(calculation: calculationsData[0].calculations[0], result: "10", additionalResult: "10")
    }
}
