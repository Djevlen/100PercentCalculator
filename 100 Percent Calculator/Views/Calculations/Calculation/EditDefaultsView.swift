//
//  EditDefaultsView.swift
//  100 Percent Calculator
//
//  Created by Thomas Andre Johansen on 24/03/2020.
//  Copyright © 2020 Appkokeriet. All rights reserved.
//

import SwiftUI

struct EditDefaultsView: View {
    var calculation: Calculation
    
    var body: some View {
        VStack{
            HStack{
                Text("Default for \(self.calculation.firstOperandString):")
                Text(self.calculation.defaultValue1 ?? "")
            }
            HStack{
                Text("Default for \(self.calculation.secondOperandString):")
                Text(self.calculation.defaultValue2 ?? "")
            }
            
        }
        
    }
}

struct EditDefaultsView_Previews: PreviewProvider {
    static var previews: some View {
        EditDefaultsView(calculation: calculationsData[0].calculations[0])
    }
}
