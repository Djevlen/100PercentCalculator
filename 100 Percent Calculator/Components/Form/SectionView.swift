//
//  SectionView.swift
//  100 Percent Calculator
//
//  Created by Thomas Andre Johansen on 19/03/2020.
//  Copyright © 2020 Appkokeriet. All rights reserved.
//

import SwiftUI


struct SectionView: View{
    @Binding var textfieldString: String
    var headerTitle: String
    var textFieldDisabled: Bool = false
    var footer: String = ""
    
    var body: some View {
        Section(header: Text(self.headerTitle)
            .font(.title)
            .fontWeight(.black),
                footer: self.footer.count > 0 ? Text(self.footer) : nil) {
                TextField(self.headerTitle, text: $textfieldString)
                .multilineTextAlignment(.trailing)
                .keyboardType(.decimalPad)
                    .disabled(self.textFieldDisabled)
                
        }
    }
}

struct SectionView_Previews: PreviewProvider {
    static var previews: some View {
        SectionView(textfieldString: .constant("lol"), headerTitle: "lol")
    }
}

