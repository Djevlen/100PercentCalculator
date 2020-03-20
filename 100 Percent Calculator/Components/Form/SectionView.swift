//
//  SectionView.swift
//  100 Percent Calculator
//
//  Created by Thomas Andre Johansen on 19/03/2020.
//  Copyright © 2020 Appkokeriet. All rights reserved.
//

import SwiftUI


struct SectionView: View{
    @Binding var operand: String
    var operandString: String
    
    var body: some View {
        Section(header: Text(self.operandString)
            .font(.title)
            .fontWeight(.black)) {
                TextField(self.operandString, text: $operand)
                .multilineTextAlignment(.trailing)
                .keyboardType(.decimalPad)
                
        }
    }
}

struct SectionView_Previews: PreviewProvider {
    static var previews: some View {
        SectionView(operand: .constant("lol"), operandString: "lol")
    }
}

