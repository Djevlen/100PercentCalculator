//
//  EditDefaultsView.swift
//  100 Percent Calculator
//
//  Created by Thomas Andre Johansen on 24/03/2020.
//  Copyright © 2020 Appkokeriet. All rights reserved.
//

import SwiftUI

struct EditDefaultsView: View {
    var calculation: Calculation
    
    @State var operand1: String = ""
    @State var operand2: String = ""
    
    var body: some View {
        VStack{
           HStack{
                Text(self.calculation.firstOperandString)
                    .font(.footnote)
            TextField(self.calculation.firstOperandString, text: $operand1)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            HStack{
                Text(self.calculation.secondOperandString)
                    .font(.footnote)
                TextField(self.calculation.secondOperandString, text: $operand2)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            VStack(alignment: .trailing){
                Button(action: {
                    print("SAVE!")
                }) {
                    Image(systemName: "wand.and.stars")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .background(Color.red)


                }
                
            }
            
        }
        
            
        
        
    }
}

struct EditDefaultsView_Previews: PreviewProvider {
    static var previews: some View {
        EditDefaultsView(calculation: calculationsData[0].calculations[0])
    }
}
