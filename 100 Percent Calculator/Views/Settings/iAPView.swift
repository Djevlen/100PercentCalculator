//
//  iAPView.swift
//  100 Percent Calculator
//
//  Created by Thomas Andre Johansen on 27/03/2020.
//  Copyright © 2020 Appkokeriet. All rights reserved.
//

import SwiftUI

struct iAPView: View {
    @EnvironmentObject var userSettings: UserSettings
    
    var body: some View {
        Group{
            
            if(userSettings.iapProductsLoaded){
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        ForEach(userSettings.iapProducts!, id:\.self){ product in
                            Group{
                                ProductView(product: product)
                            }
                            .padding()
                        }
                    }
                }

            }else{
                Text("iApProduectsLoaded false")

                //spinnverview?
            }
            Button(action: {
                print("lol")
            }){
                Text("Restore Pro Purchase")
            }
        
        }.onAppear(
            perform: userSettings.getAds
        )
    }

}
