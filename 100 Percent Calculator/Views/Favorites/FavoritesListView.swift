//
//  FavoritesListView.swift
//  100 Percent Calculator
//
//  Created by Thomas Andre Johansen on 06/04/2020.
//  Copyright © 2020 Appkokeriet. All rights reserved.
//

import SwiftUI

struct FavoritesListView: View {
    @EnvironmentObject var userSettings: UserSettings
    @ObservedObject var calculator: Calculator = Calculator()
    @EnvironmentObject var keyboard: KeyboardController


    var body: some View {
        ZStack {
            List{
                ForEach(userSettings.favoriteCalculations){ favorite in
                    FavoriteCellView(calculator: self.calculator, favorite: favorite)
                }
                .onMove(perform: moveCell)
            }.padding(.bottom, (self.keyboard.height-self.getSafeAreaInsets()))
            .listStyle(GroupedListStyle())
            VStack(alignment: .trailing){
                KeyboardButtonRow(calculator: self.calculator)
            }
        }
        .navigationBarTitle(Text("Favorites"), displayMode: .automatic)
        .navigationBarItems(trailing: EditButton())
    }
    
    func moveCell(from source: IndexSet, to destination: Int){
        userSettings.favoriteCalculations.move(fromOffsets: source, toOffset: destination)
    }
}

struct FavoritesListView_Previews: PreviewProvider {
    static var previews: some View {
        let userSettings = UserSettings(data: calculationsData, favoriteCalculations: calculationsData[0].calculations)
        let keyboard = KeyboardController()
        return FavoritesListView().environmentObject(userSettings).environmentObject(keyboard)
    }
}
