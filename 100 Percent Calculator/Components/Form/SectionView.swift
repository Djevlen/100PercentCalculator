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
    var placeholder: String
    var withPercentage: Bool {
        return self.calculation.placePercentagesSymbolOn.elementsEqual(self.placeholder)
    }
    #warning("animate this placeholder -> Text transition")
    
//    private var currencyFormatter: NumberFormatter = {
//        let currencyFormatter = NumberFormatter()
//        currencyFormatter.numberStyle = .currency
//        currencyFormatter.locale = Locale.current
//        return currencyFormatter
//    }()
    
    var body: some View {
        VStack{
            HStack{
                Text(self.header)
                    .font(.title)
                    .fontWeight(.black)
                Spacer()
                
            }
            VStack(alignment: .trailing) {
                HStack {
                    if(!textfieldString.isEmpty && !self.textFieldDisabled){
                        Text(self.placeholder)
                        .font(.footnote)
                    }
                    if(self.textFieldDisabled){
                        Text(self.placeholder)
                        .font(.largeTitle)
                    }
                    TextField(self.placeholder, text: $textfieldString)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.numberPad)
                        .disabled(self.textFieldDisabled)
                    self.withPercentage ?
                        Text("%") : nil
                }
                textfieldString.count > 0 ? nil : Divider().background(Color.red).frame(height: 1)
            }
            self.footer.count > 0 ?
                HStack{
                    Spacer()
                    Text(self.footer)
                        .font(.caption)
                        .fontWeight(.light)
                }
                : nil
        }
    }
}

struct SectionView_Previews: PreviewProvider {
    static var previews: some View {
        SectionView(textfieldString: .constant("811"), header: "header",footer: "footer", calculation: calculationsData[0].calculations[0], placeholder: "placeholder")
    }
}
