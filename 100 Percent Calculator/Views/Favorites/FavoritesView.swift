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

    var body: some View {
        Group {
            if(userSettings.favoriteCalculations.isEmpty){
                NoFavoritesView()
            }else{
                NavigationView{
                    FavoritesListView()
                }.navigationViewStyle(StackNavigationViewStyle())
            }
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        let userSettings = UserSettings(data: calculationsData, favoriteCalculations: calculationsData[0].calculations)
        return FavoritesView().environmentObject(userSettings)
    }
}
