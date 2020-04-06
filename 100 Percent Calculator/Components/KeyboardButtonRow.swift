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
    var calculator: Calculator = Calculator()
    @State private var resultCopiedOpacity: Double  = 0.0
    
    var body: some View {
        Group{
            if (self.keyboard.isPresent){
                    ZStack{
                        Button(action: {
                            self.copyResult()
                        }) {
                            VStack{
                                Image(systemName: "doc.on.doc")
                                    .padding(.top, 10)
                                Spacer()
                            }
                        }
                        .modifier(KeyboardButton())
                        .buttonStyle(BorderlessButtonStyle())
                        Text(self.calculator.result)
                            .modifier(ModifiedRoundedRectangle(color: .green))
                            .offset(x: 0, y: -65)
                            .opacity(self.resultCopiedOpacity)
                    }
                Button(action: {
                    self.done()
                }) {
                    VStack{
                        Image(systemName: "checkmark")
                            .padding(.top, 10)
                        Spacer()
                    }
                }
                .buttonStyle(BorderlessButtonStyle())
                .modifier(KeyboardButton())
            }else{
                EmptyView()
            }
        }
        .padding(.bottom, self.keyboard.height/2)
    }
    
    func copyResult(){
        if self.calculator.result.count > 0{
            self.resultCopiedOpacity = 1
            let copyResult = UIPasteboard.general
            copyResult.string = self.calculator.result
            withAnimation(.linear(duration: 2)) {
                self.resultCopiedOpacity = 0
            }
        }
    }
    
    func done(){
        self.dismissKeyboard()
    }
}

struct KeyboardButtonRow_Previews: PreviewProvider {
    static var previews: some View {
        let keyboard = KeyboardController()
        return KeyboardButtonRow(calculator: Calculator()).environmentObject(keyboard)
    }
}
