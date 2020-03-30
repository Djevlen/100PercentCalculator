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
    @State private var iapProductsLoaded: Bool  = false
    @State private var iapProducts: [SKProduct] = [SKProduct]()
    

    func getProducts(){
        IAPManager.shared.getProducts { (result) in
            print("getting products")
            DispatchQueue.main.async {
                //show temp view
                //self.delegate?.didFinishLongProcess()
                switch result{
                case .success(let products):
                    self.iapProducts = products
                case .failure(let error):
                    print("error: \(error)")
                }
            }
            self.iapProductsLoaded = true

            
        }
        
    }
    
    var body: some View {
        Group{
            
            if(self.iapProductsLoaded){
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        ForEach(self.iapProducts, id:\.self){ product in
                            Group{
                                ProductView(product: product)
                            }
                                .frame(width: 150, height: 200)
                                .foregroundColor(.white)
                                .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.blue))
                                .shadow(radius: 5)
                            .padding()
                        }
                    }
                }
                

            }else{
                Button(action: {
                    self.getProducts()
                }){
                    Text("Refresh in-App Purchases")
                }
                .frame(width: 150, height: 200)
                .foregroundColor(.white)
                .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.blue))
                .shadow(radius: 5)

                //spinnverview?
            }
            Button(action: {
                print("lol")
            }){
                Text("Restore Pro Purchase")
            }
        
        }.onAppear(
            perform: self.iapProductsLoaded ? nil : self.getProducts
        )
    }

}
