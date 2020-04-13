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
                    .underline(true, color: .underline)
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
                        .underline(true, color: .underline)
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
                HStack{
                    TextField(self.placeholder, text: $textfieldString)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad)
                        .font(compactMode ? .callout : .title)
                    self.withPercentage ? Text("%").font(compactMode ? .callout : .title) : nil
                }.padding(.horizontal, 1)
                    .overlay(
                    textfieldString.count > 0 ? nil :
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.red, style: StrokeStyle())
                )
            }
        }
    }
}

struct SectionView_Previews: PreviewProvider {
    static var previews: some View {
        SectionView(textfieldString: .constant("811"), calculation: calculationsData[0].calculations[0], placeholder: "placeholder")
    }
}
