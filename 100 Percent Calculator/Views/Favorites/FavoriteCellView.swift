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
        VStack(spacing: 1){
            HStack{
                Text(favorite.title)
                Spacer()
                StarButton(calculation: favorite)
            }.modifier(FavoriteTitleHeader())
            VStack(spacing: 1){
                SectionView(textfieldString: self.$operand1, calculation: self.favorite, placeholder: self.favorite.firstOperandString, compactMode: self.userSettings.compactFavorites)
            SectionView(textfieldString: self.$operand2, calculation: self.favorite, placeholder: self.favorite.secondOperandString, compactMode: self.userSettings.compactFavorites)
                if(self.calculator.canCalculate(operand1: operand1, operand2: operand2)){
                    ResultView(calculator:self.calculator, calculation: self.favorite, operand1: self.$operand1, operand2: self.$operand2, compactMode: self.userSettings.compactFavorites)
                }
            }.modifier(FavoriteCellBody())
        }
        .listRowBackground(Color.clear)
    }
}

struct FavoriteCellView_Previews: PreviewProvider {
    static var previews: some View {
        let userSettings = UserSettings(data: calculationsData, favoriteCalculations: calculationsData[0].calculations)
        return FavoriteCellView( calculator: Calculator(),favorite: calculationsData[0].calculations[0]).environmentObject(userSettings)
    }
}
