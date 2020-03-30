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
    
    @State private var isLoading: Bool  = false
    @State private var iapProducts: [SKProduct] = [SKProduct]()
    
    func getProducts(){
        print("isloading: \(self.isLoading)")
        self.isLoading = true
        IAPManager.shared.getProducts { (result) in
            print("getting products")
            DispatchQueue.main.async {
                switch result{
                case .success(let products):
                    self.iapProducts = products
                    self.isLoading = false
                case .failure(let error):
                    print("error: \(error)")
                }
            }
        }
        print("isloading: \(self.isLoading)")

    }
    
    var body: some View {
        HStack{
            if self.iapProducts.count == 0 {
                Button(action: {
                    self.getProducts()
                }){
                    VStack(alignment: .center){
                        Image(systemName: "arrow.clockwise.circle")
                        Text("Reload")
                            .multilineTextAlignment(.center)
                    }
                    .font(.largeTitle)
                }
                .modifier(Card(width: 150, height: 150))
            }else{
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        ForEach(self.iapProducts, id:\.self){ product in
                            Group{
                                ProductView(product: product)
                                    .padding()
                            }
                        }
                    }
                }
                .listRowInsets(EdgeInsets())
            }
        }.onAppear {
            //self.getProducts()
        }
    }
}
