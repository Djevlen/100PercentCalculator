//
//  SettingsListView.swift
//  100 Percent Calculator
//
//  Created by Thomas Andre Johansen on 25/03/2020.
//  Copyright © 2020 Appkokeriet. All rights reserved.
//

import SwiftUI

struct SettingsListView: View {
    @EnvironmentObject var userSettings: UserSettings

    
    var body: some View {
        NavigationView{
            List{
                Section{
                    Toggle(isOn: $userSettings.useCurrency) {
                        Text("Use Currency")
                    }
                    Toggle(isOn: $userSettings.startOnFavorites) {
                        Text("Open app in Favorites view")
                    }
                    Text("Restore deleted calculations")                    
                }
                Section{
                    Text("iAP View")
                }
                Section(footer: Text("(C) Appbryggeriet 2020")){
                    Text("About View + Contact Info")
                    NavigationLink(destination: PrivacyPolicyView()) {
                        Text("Privacy Policy")
                    }
                }
                
                //AboutView
                //iAPView
                //Privacy Policy
                /*SettingsView
                 Use Currency:
                 Currency: default/choose
                 Timer to unfav
                 Default Starting Tab
                 Restore Deleted Calculations
                 */
            }
            .navigationBarTitle(Text("Settings"))
            .listStyle(GroupedListStyle())
        }
    }
}

struct SettingsListView_Previews: PreviewProvider {
    static var previews: some View {
        let userSettings = UserSettings(data:  calculationsData, favoriteCalculations: [Calculation]())
        return SettingsListView().environmentObject(userSettings)
    }
}
