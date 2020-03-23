//
//  SectionView.swift
//  100 Percent Calculator
//
//  Created by Thomas Andre Johansen on 19/03/2020.
//  Copyright © 2020 Appkokeriet. All rights reserved.
//

import SwiftUI


struct SectionView: View{
    @Binding var textfieldString: String
    var header: String = ""
    var textFieldDisabled: Bool = false
    var footer: String = ""
    var calculation: Calculation
    var placeholder: String = ""
    var withPercentage: Bool {
         return self.calculation.placePercentagesSymbolOn.elementsEqual(self.placeholder)
    }
    
        #warning("lag en currencyFormatter for å formatere resultsatet")
    
    var body: some View {
        VStack{
            HStack{
                Text(self.header)
                .font(.title)
                .fontWeight(.black)
                Spacer()
                }
            HStack {
                TextField(self.placeholder, text: $textfieldString)
                    .multilineTextAlignment(.trailing)
            .keyboardType(.decimalPad)
                    .disabled(self.textFieldDisabled)
                self.withPercentage ?
                    Text("%") : nil
            }
            Text(self.footer)
                .font(.caption)
                .fontWeight(.light)
        }
    }
}

struct SectionView_Previews: PreviewProvider {
    static var previews: some View {
        SectionView(textfieldString: .constant("lol"), header: "header",footer: "footer", calculation: calculationsData[0].calculations[0])
    }
}

