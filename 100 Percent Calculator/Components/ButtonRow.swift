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
    var body: some View {
        HStack{
            Button(action: {
                print("Button")
            }, label: {
                Text("Copy")
            })
            Button(action: {
                print("Button")
            }, label: {
                Text("Reset")
            })
            Button(action: {
                print("Button")
            }, label: {
                Text("Done")
            })
        }
    }
}

struct ButtonRow_Previews: PreviewProvider {
    static var previews: some View {
        ButtonRow(calculation: calculationsData[0].calculations[0])
    }
}
