//
//  SectionView.swift
//  100 Percent Calculator
//
//  Created by Thomas Andre Johansen on 19/03/2020.
//  Copyright © 2020 Appkokeriet. All rights reserved.
//

import SwiftUI


struct SectionView: View{
    @Environment(\.colorScheme) var colorScheme

    @Binding var textfieldString: String
    var calculation: Calculation
    var placeholder: String
    var compactMode: Bool = false
    var withPercentage: Bool {
        return self.calculation.placePercentagesSymbolOn.elementsEqual(self.placeholder)
    }
    @State private var headerOpacity: Double = 0.1
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 0) {
            if(!textfieldString.isEmpty && !compactMode){
                Text(self.placeholder)
                    .font(.title)
                    .underline(true, color: Color.init(red: 38/255.0, green: 0/255.0, blue: 255/255.0))
                    .opacity(self.headerOpacity)
                    .onAppear{
                        withAnimation(.easeIn(duration: 1)){
                            self.headerOpacity = 1.0
                        }
                }
                .onDisappear{
                    self.headerOpacity = 0.1
                }
            }
            HStack {
                if (!textfieldString.isEmpty && compactMode){
                    Text(self.placeholder)
                        .font(.subheadline)
                        .underline(true, color: Color.init(red: 38/255.0, green: 0/255.0, blue: 255/255.0))
                        .opacity(self.headerOpacity)
                        .onAppear{
                            withAnimation(.easeIn(duration: 1)){
                                self.headerOpacity = 1.0
                            }
                    }
                    .onDisappear{
                        self.headerOpacity = 0.1
                    }
                }
                TextField(self.placeholder, text: $textfieldString)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numberPad)
                    .font(compactMode ? .callout : .title)
                self.withPercentage ? Text("%").font(compactMode ? .callout : .title) : nil
            }
            textfieldString.count > 0 ? nil : Divider().background(Color.red).frame(height: 1)
        }
    }
}

struct SectionView_Previews: PreviewProvider {
    static var previews: some View {
        SectionView(textfieldString: .constant("811"), calculation: calculationsData[0].calculations[0], placeholder: "placeholder")
    }
}
