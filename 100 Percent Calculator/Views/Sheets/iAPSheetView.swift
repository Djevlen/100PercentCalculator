//
//  iAPSheetView.swift
//  100 Percent Calculator
//
//  Created by Thomas Andre Johansen on 03/04/2020.
//  Copyright © 2020 Appkokeriet. All rights reserved.
//

import SwiftUI

struct iAPSheetView: View {
    @Binding var isPresenting: Bool
    @EnvironmentObject var userSettings: UserSettings
    
    var body: some View {
        VStack(){
            VStack{
                Text("100% Pro")
                    .font(.largeTitle)
                Text("Help keep the app ad-free, and enjoy all pro features - forever!")
                    .font(.subheadline)
            }
            .padding()
            HStack{
                if self.userSettings.hasLoadedProducts && self.userSettings.proProduct != nil {
                    ProductView(product: self.userSettings.proProduct!)
                        .padding()
                }else{
                    //TODO: dette bør være en automagisk greie som spinner og laster inn stæsj
                    Button(action: {
                        self.userSettings.loadProducts()
                    }){
                        VStack(alignment: .center){
                            Image(systemName: "arrow.clockwise.circle")
                            Text("Reload")
                                .multilineTextAlignment(.center)
                        }
                        .font(.largeTitle)
                    }
                    .modifier(Card(width: 150, height: 150))
                }
            }
            .onAppear {
                self.userSettings.hasLoadedProducts ? nil : self.userSettings.loadProducts()
            }
            Spacer()
            Button(action: {
                //todo make this
            }){
                Text("Restore Pro Purchase")
            }
            .disabled(self.userSettings.isProUser)
            Spacer()
            Button(action: {
                self.isPresenting = false
            }) {
                Text("No thanks!")
                    .modifier(GreenRoundedRectangle())
            }
        }
    }
}

struct iAPSheetView_Previews: PreviewProvider {
    static var previews: some View {
        let userSettings = UserSettings(data:  calculationsData, favoriteCalculations: [Calculation]())
        
        return iAPSheetView(isPresenting: .constant(true)).environmentObject(userSettings)
    }
}
