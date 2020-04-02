//
//  CalculationHost.swift
//  100 Percent Calculator
//
//  Created by Thomas Andre Johansen on 25/03/2020.
//  Copyright © 2020 Appkokeriet. All rights reserved.
//

import SwiftUI

struct CalculationHost: View {
    @Environment(\.editMode) var mode
    var calculation: Calculation


    var body: some View {
            VStack{
                if self.mode?.wrappedValue == .inactive {
                    CalculationView(calculation: self.calculation)
                } else {
                    EditDefaultsView(calculation: self.calculation)
                }
            }
        .navigationBarTitle(Text(self.calculation.title), displayMode: .inline)
        .navigationBarItems(trailing: EditButton())
    }
}

struct CalculationHost_Previews: PreviewProvider {
    static var previews: some View {
        CalculationHost(calculation: calculationsData[0].calculations[0])
    }
}
