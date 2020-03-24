//
//  ButtonRow.swift
//  100 Percent Calculator
//
//  Created by Thomas Andre Johansen on 23/03/2020.
//  Copyright © 2020 Appkokeriet. All rights reserved.
//

import SwiftUI

struct ButtonRow: View {
    @EnvironmentObject var userSettings: UserSettings
    var calculation: Calculation
    @Binding var operand1: String
    @Binding var operand2: String
    @Binding var result: String

    
    var body: some View {
        HStack{
                Image(systemName: "doc.on.doc")
                .padding()
                .border(Color.blue, width: 2)
                    .onTapGesture {
                         self.copyResult()
                }
                Image(systemName: "checkmark")
                    .padding()
                    .border(Color.blue, width: 2)
                    .onTapGesture {
                        self.done()
                }

        }
    }
    
    func copyResult(){
        let copyResult = UIPasteboard.general
        copyResult.string = self.result
    }
    
    func done(){
        self.operand1 = ""
        self.operand2 = ""
    }
}

struct ButtonRow_Previews: PreviewProvider {
    static var previews: some View {
        ButtonRow(calculation: calculationsData[0].calculations[0], operand1: .constant("10"), operand2: .constant("10"), result: .constant("20")).environmentObject(UserSettings(data: calculationsData, favoriteCalculations: [Calculation](), startingTab: "lol"))
    }
}
