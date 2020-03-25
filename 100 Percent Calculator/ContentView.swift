//
//  ContentView.swift
//  100 Percent Calculator
//
//  Created by Thomas Andre Johansen on 17/03/2020.
//  Copyright © 2020 Appkokeriet. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userSettings: UserSettings
    
    var body: some View {
        TabView(selection: $userSettings.selectedTab){
            
            CalculationsListView()
                .tabItem{
                    Image(systemName: "percent")
                    Text("Calculations")
            }
            .tag("Calculations")
            
            FavoritesView()
                .tabItem{
                    Image(systemName: "star.fill")
                    Text("Favorites")
            }
            .tag("Favorites")
            
            SettingsListView()
                .tabItem{
                    Image(systemName: "gear")
                    Text("Settings")
            }
            .tag("Settings")
        }
    }
}

//extension to configure appearance
extension UITabBarController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        let standardAppearance = UITabBarAppearance()
        
        // update the appearance
        
        
        tabBar.standardAppearance = standardAppearance
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let userSettings = UserSettings(data:  calculationsData, favoriteCalculations: [Calculation]())
        return ContentView().environmentObject(userSettings)
    }
}
