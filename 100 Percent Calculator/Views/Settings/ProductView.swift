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
    @State private var showBuyError: Bool = false
    @State private var showIAPError: Bool = false
    @State private var iapErrorString = "An error occured."

    var product: SKProduct
    var localizedPrice: String {
        guard let price = IAPManager.shared.getPriceFormatted(for: product) else { return product.price.stringValue}
        return price
    }
    var body: some View {
        VStack{
            Button(action: {
                if !self.purchase(product: self.product){
                    self.showBuyError.toggle()
                }
            }) {
                VStack{
                    Text("\(product.localizedTitle)")
                        .font(.title)
                        .padding([.top, .horizontal])
                    
                    Text("\(self.localizedPrice)")
                        .font(.subheadline)
                    Image(systemName: getImageFrom(productID: product.productIdentifier))
                    Spacer()
                    Text("\(product.localizedDescription)")
                        .font(.body)
                        .multilineTextAlignment(.leading)
                        .padding([.bottom, .horizontal])
                }
                
            }
                //alert for when the device is unable to buy stuff
                //ie parents locking a child's device etc
            .alert(isPresented: $showBuyError) {
                Alert(title: Text("Error Making Purchase"), message: Text("This device cannot make purchases"), dismissButton: .default(Text("Ok!")))
            }
            .alert(isPresented: $showIAPError){
                Alert(title: Text("Error"), message: Text(iapErrorString), dismissButton: .default(Text("Ok!")))
            }
        }
        .frame(width: 150, height: 200)
        .foregroundColor(.white)
        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.blue))
        .shadow(radius: 5)
    }
    
    func getImageFrom(productID: String) -> String{
        switch productID {
        case "100percentPro":
            return "heart.fill"
        case "smallestTip":
            return "heart"
        case "mediumTip":
            return "heart.circle"
        case "largeTip":
            return "heart.circle.fill"
        default:
            return "pencil.slash"
        }
        #warning("fix default pencil.slash")
    }
    
    func purchase(product: SKProduct) -> Bool {
        if !IAPManager.shared.canMakePayments() {
            return false
        } else {
            //show timeoutview
            //delegate?.willStartLongProcess()
            IAPManager.shared.buy(product: product) { (result) in
                DispatchQueue.main.async {
                    //remove timeoutview
                    //self.delegate?.didFinishLongProcess()
                    
                    switch result {
                    case .success(_): self.userBoughtProduct(product)
                    case .failure(let error): self.showIAPRelatedError(error)
                    }
                }
            }
            return true
        }
        
    }
    
    func userBoughtProduct(_ product: SKProduct){
        print("the user bought this: \(product.localizedTitle)")
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

