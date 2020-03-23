//
//  FavoriteCellView.swift
//  100 Percent Calculator
//
//  Created by Thomas Andre Johansen on 19/03/2020.
//  Copyright © 2020 Appkokeriet. All rights reserved.
//

import SwiftUI

struct FavoriteCellView: View {
    @ObservedObject var calculator: Calculator = Calculator()
    var favorite: Calculation
    @State var operand1: String = ""
    @State var operand2: String = ""
    
    var body: some View {
        VStack{
            HStack{
                Text(favorite.title)
                Spacer()
                StarButton(calculation: self.favorite)
            }
            SectionView(textfieldString: $operand1, calculation: self.favorite, placeholder: self.favorite.firstOperandString)
            SectionView(textfieldString: $operand2, calculation: self.favorite, placeholder: self.favorite.secondOperandString)
            if(self.calculator.canCalculate(operand1: self.operand1, operand2: self.operand2)){
                ResultView(calculation: self.favorite, operand1: self.$operand1, operand2: self.$operand2)
            }
            
    }
        .padding()
    
}
}

struct FavoriteCellView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteCellView(favorite: calculationsData[0].calculations[0])
    }
}
