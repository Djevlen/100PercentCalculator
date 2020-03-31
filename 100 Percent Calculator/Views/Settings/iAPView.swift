//
//  iAPView.swift
//  100 Percent Calculator
//
//  Created by Thomas Andre Johansen on 27/03/2020.
//  Copyright © 2020 Appkokeriet. All rights reserved.
//

import SwiftUI
import StoreKit

struct iAPView: View {
    @EnvironmentObject var userSettings: UserSettings
    
    var body: some View {
        Group{
            HStack{
                if self.userSettings.hasLoadedProducts && self.userSettings.products != nil {
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack{
                            ForEach(self.userSettings.products!, id:\.self){ product in
                                Group{
                                    ProductView(product: product)
                                        .padding()
                                }
                            }
                            
                        }
                    }
                }else{
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
            .listRowInsets(EdgeInsets())
            .onAppear {
                self.userSettings.hasLoadedProducts ? nil : self.userSettings.loadProducts()
            }
            Button(action: {
                print("lol")
            }){
                Text("Restore Pro Purchase")
            }
        }
    }
}
