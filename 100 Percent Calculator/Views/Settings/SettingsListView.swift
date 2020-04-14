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
                    Toggle(isOn: $userSettings.compactFavorites) {
                        Text("Compact Favorites")
                    }
                    Button(action: {
                        self.userSettings.restoreCalculations()
                    }) {
                        Text("Restore deleted calculations")
                    }
                    .alert(isPresented: self.$userSettings.restoredCalculations){
                        Alert(title: Text("Reset"), message: Text("\(self.userSettings.restoredCalculationsCount) Calculations restored"), dismissButton: .default(Text("OK")))
                    }
                }
                Section(header: Image(systemName: "cart") ){
                    Text("Buy Pro to get all current and future pro features, and keep the app ad-free. Or consider skipping buying that coffee today and give me a tip below, so I can buy myself a coffee instead! ❤️ 😅")
                    Button(action: {
                        self.userSettings.favoriteLimitReached = true
                    }) {
                        Text("Why Pro?")
                    }
                    iAPView()
                }
                Section(header: Text("About"), footer: Text("© Appbryggeriet 2020 🇳🇴")){
                    AboutView()
                    Button(action: {
                        let url = URL(string: "https://apps.apple.com/us/app/100-percent-calculator/id1080209973?ls=1")
                        var components = URLComponents(url: url!, resolvingAgainstBaseURL: false)
                        components?.queryItems = [
                          URLQueryItem(name: "action", value: "write-review")
                        ]
                        guard let reviewURL = components?.url else {
                          return
                        }
                        UIApplication.shared.open(reviewURL)
                    }) {
                        Text("Write a Review")
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
        }.navigationViewStyle(StackNavigationViewStyle())
            .sheet(isPresented: self.$userSettings.favoriteLimitReached) {
            iAPSheetView(isPresenting: self.$userSettings.favoriteLimitReached).environmentObject(self.userSettings)
        }
    }
}

struct SettingsListView_Previews: PreviewProvider {
    static var previews: some View {
        let userSettings = UserSettings(data:  calculationsData, favoriteCalculations: [Calculation]())
        return SettingsListView().environmentObject(userSettings)
    }
}
