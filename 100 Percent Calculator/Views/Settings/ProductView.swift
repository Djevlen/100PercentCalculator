//
//  ProductView.swift
//  100 Percent Calculator
//
//  Created by Thomas Andre Johansen on 27/03/2020.
//  Copyright © 2020 Appkokeriet. All rights reserved.
//

import SwiftUI
import StoreKit

struct ProductView: View {
    @EnvironmentObject var userSettings: UserSettings
    @State private var showBuyError: Bool = false
    @State private var showIAPError: Bool = false
    @State private var iapErrorString = "An error occured."
    @State private var tryingToBuy = false
    @State private var thankUser = false
    var compactMode: Bool = false
    
    var product: SKProduct
    var localizedPrice: String {
        guard let price = IAPManager.shared.getPriceFormatted(for: product) else { return product.price.stringValue}
        return price
    }
    var body: some View {
        VStack{
            if self.compactMode{
                Button(action: {
                    if !self.purchase(product: self.product){
                        self.showBuyError.toggle()
                    }
                }){
                    if self.tryingToBuy{
                        Spinner()
                    }else{
                        Text("Buy!")
                    }
                }
            }else{
                Button(action: {
                    if !self.purchase(product: self.product){
                        self.showBuyError.toggle()
                    }
                }) {
                    if self.tryingToBuy{
                        Spinner().padding()
                    }else{
                        VStack{
                            Text("\(product.localizedTitle)")
                                .font(.title)
                                .padding([.top, .horizontal])
                            Text("\(self.localizedPrice)")
                                .font(.subheadline)
                            Spacer()
                            Image(systemName: getImageFrom(productID: product.productIdentifier))
                                .font(self.applyFontWeight(for: product.productIdentifier))
                            Spacer()
                            Text("\(product.localizedDescription)")
                                .font(.body)
                                .multilineTextAlignment(.center)
                                .padding([.bottom, .horizontal])
                        }
                    }
                }
                .modifier(Card(width: 150, height: 250))
                    //alert for when the device is unable to buy stuff
                    //ie parents locking a child's device etc
                    .alert(isPresented: $showBuyError) {
                        Alert(title: Text("Error Making Purchase"), message: Text("This device cannot make purchases"), dismissButton: .default(Text("Ok!")))
                }
                .alert(isPresented: $showIAPError){
                    Alert(title: Text("Error"), message: Text(iapErrorString), dismissButton: .default(Text("Ok!")))
                }
                
            }
            
        }.alert(isPresented: self.$thankUser){
                Alert(title: Text("Thank You!"), message: Text("Your help is greatly appreciated! ❤️"), dismissButton: .default(Text("Dismiss!")))
                //TODO : create thank you view?
        }
    }
    func applyFontWeight(for product: String) -> Font?{
        switch product {
        case "100percentPro":
            return .largeTitle
        case "smallestTip":
            return .body
        case "mediumTip":
            return .title
        case "largeTip":
            return .largeTitle
        default:
            return .body
        }
    }
    func getImageFrom(productID: String) -> String{
        switch productID {
        case "100percentPro":
            return "heart.fill"
        default:
            return "heart.circle.fill"
        }
    }
    
    func purchase(product: SKProduct) -> Bool {
        if !IAPManager.shared.canMakePayments() {
            self.tryingToBuy = false
            return false
        } else {
            self.tryingToBuy = true
            IAPManager.shared.buy(product: product) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(_):
                        print("the user bought this: \(product.localizedTitle)")
                        if product.productIdentifier.lowercased().contains("pro"){
                            self.userSettings.isProUser = true
                            self.userSettings.hasLoadedProducts = false
                        }
                        self.thankUser = true
                    case .failure(let error): self.showIAPRelatedError(error)
                    }
                }
            }
            return true
        }
    }
    
    func showIAPRelatedError(_ error: Error){
        print("got an error: \(error.localizedDescription)")
        self.iapErrorString = error.localizedDescription
        self.showIAPError = true
    }
    
}


struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        let prod = SKProduct()
        return ProductView(product: prod)
    }
}

