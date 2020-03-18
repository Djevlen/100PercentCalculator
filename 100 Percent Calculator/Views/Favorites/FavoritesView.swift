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
       Group { if(userSettings.favoriteCalculations.isEmpty){
            
                Text("fav.title")
            
        }else{
             ForEach(userSettings.favoriteCalculations){ fav in
                    Text(fav.title)
            }
        }
        }
        
            
        
    }
}
//
//struct FavoritesView_Previews: PreviewProvider {
//    static var previews: some View {
//        FavoritesView()
//    }
//}
