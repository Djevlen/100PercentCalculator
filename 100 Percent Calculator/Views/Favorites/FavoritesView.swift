//
//  FavoritesView.swift
//  100 Percent Calculator
//
//  Created by Thomas Andre Johansen on 18/03/2020.
//  Copyright © 2020 Appkokeriet. All rights reserved.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var userSettings: UserSettings
    @ObservedObject var calculator: Calculator = Calculator()

    
    var body: some View {
        Group {
            //user has no favorites
            if(userSettings.favoriteCalculations.isEmpty){
                NoFavoritesView()
            }else{
                NavigationView{
                    ZStack {
                        List{
                            ForEach(userSettings.favoriteCalculations){ favorite in
                                FavoriteCellView(calculator: self.calculator, favorite: favorite)
                            }
                        .onMove(perform: moveCell)
                        }
                        .listStyle(PlainListStyle())
                        .navigationBarTitle(Text("Favorites"), displayMode: .inline).navigationBarItems(trailing: EditButton())
                        VStack(alignment: .trailing){
                            Spacer()
                            HStack{
                                Spacer()
                                KeyboardButtonRow(calculator: self.calculator)
                            }
                        }
                    }
                }
                
                
            }
        }
        
        
        
    }
    
    func moveCell(from source: IndexSet, to destination: Int){
        userSettings.favoriteCalculations.move(fromOffsets: source, toOffset: destination)
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        let userSettings = UserSettings(data: calculationsData, favoriteCalculations: calculationsData[0].calculations)
        return FavoritesView().environmentObject(userSettings)
    }
}
