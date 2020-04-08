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
    var bottomButtonPadding: CGFloat = 30
    
    var body: some View {
        GeometryReader{ geometry in
            if (self.keyboard.isPresent){
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        ZStack{
                            Button(action: {
                                self.copyResult()
                            }) {
                                Image(systemName: "doc.on.doc")
                                    .padding()
                            }
                            .padding(.bottom, self.bottomButtonPadding)
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
                            Image(systemName: "checkmark")
                                .padding()
                        }
                        .padding(.bottom, self.bottomButtonPadding)
                        .modifier(KeyboardButton())
                        .buttonStyle(BorderlessButtonStyle())
                    }
                    
                }.edgesIgnoringSafeArea(.vertical)
                    .offset(x: 0, y: -(self.keyboard.height-geometry.safeAreaInsets.bottom)+self.bottomButtonPadding)
                    .transition(.move(edge: .bottom))
                    .animation(.spring())
            }else{
                EmptyView()
            }
        }
        
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
