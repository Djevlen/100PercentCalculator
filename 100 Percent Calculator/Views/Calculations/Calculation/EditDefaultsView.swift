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
            self.userSettings.resetDefaultOperandValues(for: self.calculation)
            return
        }
        self.userSettings.saveDefaultOperandValue(calculation: self.calculation, operands: (operand1, operand2))
    }
    
    private func reset(){
        self.userSettings.resetDefaultOperandValues(for: self.calculation)
    }
    
    var body: some View {
        ZStack{
            VStack{
                HStack {
                    Text(self.calculation.title)
                        .fontWeight(.heavy)
                    Spacer()
                }.modifier(LargeTitleHeader())
                HStack {
                    Text("Default Values")
                        .font(.largeTitle)
                        .underline(true, color: .underline)
                        .fontWeight(.heavy)
                        .padding(.horizontal, 10)
                    Spacer()
                }
                
                VStack{
                    VStack {
                        SectionView(textfieldString: $operand1, calculation: self.calculation, placeholder: self.calculation.firstOperandString)
                            .onAppear{
                                    self.operand1 = self.calculation.defaultOperand1 ?? ""
                            }
                        SectionView(textfieldString: $operand2, calculation: self.calculation, placeholder: self.calculation.secondOperandString)
                        .onAppear{
                                self.operand2 = self.calculation.defaultOperand2 ?? ""
                        }
                    }.modifier(SectionViewGroup())
                }
                HStack{
                    Spacer()
                    Button(action: {
                        self.reset()
                    }) {
                        Text("Reset")
                            .padding()
                    }
                    .modifier(ModifiedRoundedRectangle())
                    Button(action: {
                        self.save()
                    }) {
                        Text("Save")
                            .padding()
                    }
                    .modifier(ModifiedRoundedRectangle())
                }.padding()
                Spacer()
            }
            VStack(alignment: .trailing){
                KeyboardButtonRow()
            }
        }
    }
}

struct EditDefaultsView_Previews: PreviewProvider {
    static var previews: some View {
        EditDefaultsView(calculation: calculationsData[0].calculations[0]).environmentObject(UserSettings(data: calculationsData, favoriteCalculations: [Calculation]()))
    }
}
