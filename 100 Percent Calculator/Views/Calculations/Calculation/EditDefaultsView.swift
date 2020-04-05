//
//  EditDefaultsView.swift
//  100 Percent Calculator
//
//  Created by Thomas Andre Johansen on 24/03/2020.
//  Copyright © 2020 Appkokeriet. All rights reserved.
//

import SwiftUI

struct EditDefaultsView: View {
    @EnvironmentObject var userSettings: UserSettings
    
    var calculation: Calculation
    
    @State var operand1: String = ""
    @State var operand2: String = ""
    
    private func save(){
        guard operand1.count > 0 || operand2.count > 0 else{
            return
        }
        self.userSettings.saveDefaultOperandValue(calculation: self.calculation, operands: (operand1, operand2))
    }
    
    var body: some View {
        VStack{
            HStack {
                Text("Default Values")
                .fontWeight(.heavy)

                Spacer()
            }.modifier(LargeTitleHeader())
            
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
            HStack{
                Spacer()
                Button(action: {
                    self.save()
                }) {
                    Text("Save")
                        .padding()
                }
            }
            Spacer()
        }
    }
}

struct EditDefaultsView_Previews: PreviewProvider {
    static var previews: some View {
        EditDefaultsView(calculation: calculationsData[0].calculations[0]).environmentObject(UserSettings(data: calculationsData, favoriteCalculations: [Calculation]()))
    }
}
