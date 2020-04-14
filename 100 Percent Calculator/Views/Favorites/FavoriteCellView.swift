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
            VStack(spacing: 5){
                SectionView(textfieldString: self.$operand1, calculation: self.favorite, placeholder: self.favorite.firstOperandString, compactMode: self.userSettings.compactFavorites)
                    .onAppear{
                        self.operand1 = self.favorite.defaultOperand1 ?? ""
                }
                SectionView(textfieldString: self.$operand2, calculation: self.favorite, placeholder: self.favorite.secondOperandString, compactMode: self.userSettings.compactFavorites)
                .onAppear{
                        self.operand2 = self.favorite.defaultOperand2 ?? ""
                }
                ResultView(calculator:self.calculator, calculation: self.favorite, operand1: self.$operand1, operand2: self.$operand2, compactMode: self.userSettings.compactFavorites)
            }.modifier(FavoriteCellBody())
        }
        .listRowBackground(Color.primary.colorInvert())
    }
}

struct FavoriteCellView_Previews: PreviewProvider {
    static var previews: some View {
        let userSettings = UserSettings(data: calculationsData, favoriteCalculations: calculationsData[0].calculations)
        return FavoriteCellView( calculator: Calculator(),favorite: calculationsData[0].calculations[0]).environmentObject(userSettings)
    }
}
