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
                    Text("Dismiss")
                }
                .offset(x: 0, y: -self.keyboard.height)
            }else{
                EmptyView()
            }

        }
                
    }
}

struct DismissKeyboardButton_Previews: PreviewProvider {
    static var previews: some View {
        DismissKeyboardButton()
    }
}
