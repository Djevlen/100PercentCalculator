//
//  KeyboardButtonRow.swift
//  100 Percent Calculator
//
//  Created by Thomas Andre Johansen on 02/04/2020.
//  Copyright © 2020 Appkokeriet. All rights reserved.
//

import SwiftUI

struct KeyboardButtonRow: View {
    @EnvironmentObject var keyboard: KeyboardController
    var calculator: Calculator
    var body: some View {
        Group{
            if (self.keyboard.isPresent){
                Button(action: {
                    self.copyResult()
                }) {
                    VStack{
                        Image(systemName: "doc.on.doc")
                            .padding(.top, 10)
                        Spacer()
                    }
                }
                .buttonStyle(BorderlessButtonStyle())
                .modifier(Card(width: 100, height: 110))
                
                Button(action: {
                    self.dismissKeyboard()
                }) {
                    VStack{
                        Image(systemName: "checkmark")
                            .padding(.top, 10)
                        Spacer()
                    }
                }
                .buttonStyle(BorderlessButtonStyle())
                .modifier(Card(width: 100, height: 110))
            }else{
                EmptyView()
            }
        }
        .padding(.bottom, self.keyboard.height/2)
    }
    
    func copyResult(){
        let copyResult = UIPasteboard.general
        copyResult.string = self.calculator.result
        
    }
}

struct KeyboardButtonRow_Previews: PreviewProvider {
    static var previews: some View {
        let keyboard = KeyboardController()
        return KeyboardButtonRow(calculator: Calculator()).environmentObject(keyboard)
    }
}
