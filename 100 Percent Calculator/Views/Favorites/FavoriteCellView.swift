//
//  FavoriteCellView.swift
//  100 Percent Calculator
//
//  Created by Thomas Andre Johansen on 19/03/2020.
//  Copyright © 2020 Appkokeriet. All rights reserved.
//

import SwiftUI

struct FavoriteCellView: View {
    @EnvironmentObject var userSettings: UserSettings
    @EnvironmentObject var keyboard: KeyboardController
    var calculator: Calculator
    var favorite: Calculation
    @State var operand1: String = ""
    @State var operand2: String = ""
    
    var body: some View {
        VStack{
            HStack{
                Text(favorite.title)
                Spacer()
                StarButton(calculation: favorite)
            }
            VStack{
                SectionView(textfieldString: self.$operand1, calculation: self.favorite, placeholder: self.favorite.firstOperandString)
                SectionView(textfieldString: self.$operand2, calculation: self.favorite, placeholder: self.favorite.secondOperandString)
                    if(self.calculator.canCalculate(operand1: operand1, operand2: operand2)){
                        ResultView(calculator:self.calculator, calculation: self.favorite, operand1: self.$operand1, operand2: self.$operand2)
                    }
            }
           
        }
        .padding()
    }
}

struct FavoriteCellView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteCellView( calculator: Calculator(),favorite: calculationsData[0].calculations[0])
    }
}
