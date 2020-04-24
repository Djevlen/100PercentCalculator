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
        ScrollView{
            VStack(){
                HStack(){
                    Text("100% Pro")
                    Spacer()
                }.modifier(LargeTitleHeader())
                Text("Help keep the app ad-free, and enjoy all pro features - forever!")
                    .font(.subheadline)
                    .padding()
                HStack{
                    if self.userSettings.hasLoadedProducts && IAPManager.shared.proProduct != nil {
                        ProductView(product: IAPManager.shared.proProduct!)
                            .padding()
                    }else{
                        Spinner()
                            .onAppear{
                                IAPManager.shared.loadProducts(userSettings: self.userSettings)
                            }
                    }
                }
                VStack(alignment: .leading){
                    HStack{
                        Text("Current Pro Features")
                            .font(.title)
                            .underline(true, color: .underline)
                        Spacer()
                    }
                    Text("- No Ads.")
                    Text("- Unlimited Favorites")
                    Text("")
                    Text("With more features on the way!")
                }.padding()
                HStack{
                    Button(action: {
                        self.isPresenting = false
                    }) {
                        Text("No thanks!")
                            .modifier(ModifiedRoundedRectangle(color: .red))
                    }
                    Button(action: {
                        self.isPresenting = false
                    }) {
                        if IAPManager.shared.proProduct != nil {
                            ProductView(compactMode: true, product: IAPManager.shared.proProduct!)
                                                    .modifier(ModifiedRoundedRectangle())
                        }else{
                            Spinner()
                        }
                        
                    }
                }.padding()
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
