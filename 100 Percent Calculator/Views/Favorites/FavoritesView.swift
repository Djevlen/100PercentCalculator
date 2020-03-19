//
//  FavoritesView.swift
//  100 Percent Calculator
//
//  Created by Thomas Andre Johansen on 18/03/2020.
//  Copyright © 2020 Appkokeriet. All rights reserved.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject private var userSettings: UserSettings
    
    var body: some View {
        Group {
            //user has no favorites
            if(userSettings.favoriteCalculations.isEmpty){
                Text("fav.title")
                //NoFavoriteCalculationView
            }else{
                List(userSettings.favoriteCalculations){ favorite in
                    FavoriteCellView(favorite: favorite)
                }
            }
        }
        
        
        
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        let userSettings = UserSettings(data: calculationsData, favoriteCalculations: calculationsData[0].calculations, startingTab: "Favorites")
        return FavoritesView().environmentObject(userSettings)
    }
}
