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
    var calculator: Calculator?
    @State private var resultCopiedOpacity: Double  = 0.0
    @State private var calculatorResult: String = ""
    var bottomButtonPadding: CGFloat = 30
    
    var body: some View {
        GeometryReader{ geometry in
            if (self.keyboard.isPresent){
                VStack(alignment: .center){
                    if (self.calculatorResult.count > 0){
                        Spacer()
                        HStack{
                            Spacer()
                            Text(self.calculatorResult)
                            .font(.largeTitle)
                            .padding()
                            .modifier(ModifiedRoundedRectangle(color: .green))
                            .opacity(self.resultCopiedOpacity)
                            Spacer()
                        }
                        Spacer()
                    }
                }
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        Button(action: {
                            self.copyResult()
                        }) {
                            Image(systemName: "doc.on.doc")
                                .padding()
                        }
                        .padding(.bottom, self.bottomButtonPadding)
                        .modifier(KeyboardButton())
                        .buttonStyle(BorderlessButtonStyle())
                        
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
                }
                .transition(.move(edge: .bottom))
                .animation(.spring())
                .offset(x: 0, y: -(self.keyboard.height-geometry.safeAreaInsets.bottom)+self.bottomButtonPadding)
                .padding(.horizontal)
                
                
            }else{
                EmptyView()
            }
        }
        
    }
    
    func copyResult(){
        if self.calculator?.result.count ?? 0 > 0{
            self.resultCopiedOpacity = 1
            let copyResult = UIPasteboard.general
            copyResult.string = self.calculator?.result ?? ""
            self.calculatorResult = self.calculator?.result ?? ""
            withAnimation(Animation.easeOut(duration: 1.5)){
                self.resultCopiedOpacity = 0
                self.calculatorResult = ""
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
