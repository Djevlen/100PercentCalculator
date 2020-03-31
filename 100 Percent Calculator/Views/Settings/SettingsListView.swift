//
//  SettingsListView.swift
//  100 Percent Calculator
//
//  Created by Thomas Andre Johansen on 25/03/2020.
//  Copyright © 2020 Appkokeriet. All rights reserved.
//

import SwiftUI
import StoreKit

struct SettingsListView: View {
    @EnvironmentObject var userSettings: UserSettings
    
    
    
    
    var body: some View {
        NavigationView{
            List{
                Section{
//                    Toggle(isOn: $userSettings.useCurrency) {
//                        Text("Use Currency")
//                    }
                    Toggle(isOn: $userSettings.startOnFavorites) {
                        Text("Start app in Favorites")
                    }
                    Toggle(isOn: $userSettings.unfavoriteTimer) {
                        Text("Unfavorite Timer")
                    }
                    Button(action: {
                        self.userSettings.restoreCalculations()
                    }) {
                        Text("Restore deleted calculations")
                    }
                    .alert(isPresented: self.$userSettings.restoredCalculations){
                        Alert(title: Text("Reset"), message: Text("All Calculations restored"), dismissButton: .default(Text("Ok!")))
                    }
                }
                Section(header: Text("iAP")){
                    iAPView()
                }
                Section(header: Text("About"), footer: Text("© Appbryggeriet 2020 🇳🇴")){
                    AboutView()
                    Button(action: {
                        SKStoreReviewController.requestReview()
                    }) {
                        Text("Leave a review")
                    }
                    Button(action: {
                        let url = URL(string: "https://www.instagram.com/thomasajajaj/")
                        UIApplication.shared.open(url!)
                    }) {
                        Text("Dent and I on Instagram!")
                    }
                    Button(action: {
                        let url = URL(string: "mailto:thomasaj@gmail.com")
                        UIApplication.shared.open(url!)
                    }) {
                        Text("Report a bug")
                    }
                    NavigationLink(destination: PrivacyPolicyView()) {
                        Text("Privacy Policy")
                    }
                }
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
