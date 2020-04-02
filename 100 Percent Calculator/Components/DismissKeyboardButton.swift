//
//  DismissKeyboardButton.swift
//  100 Percent Calculator
//
//  Created by Thomas Andre Johansen on 02/04/2020.
//  Copyright © 2020 Appkokeriet. All rights reserved.
//

import SwiftUI

struct DismissKeyboardButton: View {
    @EnvironmentObject var keyboard: KeyboardController
    var body: some View {
        Group{
            if (self.keyboard.isPresent){
                
                Button(action: {
                    self.dismissKeyboard()
                }) {
                    VStack{
                    Image(systemName: "doc.on.doc")
                        .padding(.top, 10)
                        Spacer()
                    }
                }
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
                .modifier(Card(width: 100, height: 110))

                
            }else{
                EmptyView()
            }
        }
        .padding(.bottom, self.keyboard.height/2)
        
        //        GeometryReader{ geo in
        //            if (self.keyboard.isPresent){
        //                    Button(action: {
        //                        self.dismissKeyboard()
        //                    }) {
        //                        Text("geo: \(geo.size.height), key: \(self.keyboard.height)")
        //                    }
        //                }
        //        else{
        //                Text("geo: \(geo.size.height), key: \(self.keyboard.height)")
        //            }
        //        }
        
    }
}

struct DismissKeyboardButton_Previews: PreviewProvider {
    static var previews: some View {
        let keyboard = KeyboardController()
        return DismissKeyboardButton().environmentObject(keyboard)
    }
}
