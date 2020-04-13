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
    @State private var showIAPError: Bool = false
    @State private var iapErrorString = "An error occured."
    @State private var tryingToRestorePro = false
    @State private var proRestored: Bool = false
    
    
    var body: some View {
        Group{
            if (self.tryingToRestorePro){
                Spinner()
                    .transition(.scale)
                    .animation(.easeInOut(duration: 10))
                .padding()
            }else{
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
                    Spinner()
                    .onAppear(perform: self.userSettings.loadProducts)
                }
            }
            .listRowInsets(EdgeInsets())
            }
                Button(action: {
                    self.restorePro()
                }){
                    Text("Restore Pro Purchase")
                }
                .disabled(self.userSettings.isProUser)
            
        }
        .alert(isPresented: $showIAPError){
            Alert(title: Text("Error"), message: Text(iapErrorString), dismissButton: .default(Text("Ok!")))
        }
        .alert(isPresented: $proRestored){
            Alert(title: Text("Restored"), message: Text("Pro has been restored. Thank you! ❤️"), dismissButton: .default(Text("Ok!")))
        }
    }
    
    func restorePro() {
        print("tryint to restore purchase")
        self.tryingToRestorePro = true
        IAPManager.shared.restorePurchases { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    if success {
                        self.userSettings.isProUser = true
                        self.userSettings.hasLoadedProducts = false
                        self.proRestored = true
                    } else {
                        self.iapErrorString = "No Products to Restore"
                        self.showIAPError = true
                    }
                    
                case .failure(let error): self.showIAPRelatedError(error)
                }
                self.tryingToRestorePro = false
            }
        }
    }
    
    func showIAPRelatedError(_ error: Error){
        print("got an error: \(error.localizedDescription)")
        self.iapErrorString = error.localizedDescription
        self.showIAPError = true
    }
}
