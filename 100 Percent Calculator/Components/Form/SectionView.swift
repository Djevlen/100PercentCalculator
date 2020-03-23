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
                self.header.count > 0 ? Text(self.header)
                .font(.title)
                .fontWeight(.black)
                 : nil
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
            self.footer.count > 0 ? Text(self.footer)
            .font(.title)
            .fontWeight(.black)
             : nil
        }
    }
}

struct SectionView_Previews: PreviewProvider {
    static var previews: some View {
        SectionView(textfieldString: .constant("lol"), header: "lol", calculation: calculationsData[0].calculations[0])
    }
}

