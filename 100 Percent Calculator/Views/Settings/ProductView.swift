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
    var product: SKProduct
//    var product: [String: String] = ["localizedTitle": "100% Pro","price": "5", "localizedDescription": "All Pro features. No ads. Forever.", "productIdentifier": "100percentPro"]
    var body: some View {
            VStack{
                Button(action: {
                    print("try to buy \(self.product.localizedTitle)")
                }) {
                    VStack{
                        Text("\(product.localizedTitle)")
                            .font(.title)
                        .padding([.top, .horizontal])

                        Text("\(product.price) NOK")
                            .font(.subheadline)
                        Image(systemName: getImageFrom(productID: product.productIdentifier))
                        Spacer()
                        Text("\(product.localizedDescription)")
                            .font(.body)
                            .multilineTextAlignment(.leading)
                            .padding([.bottom, .horizontal])
                    }
                    
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
        #warning("fix default over")
    }
}


struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        let prod = SKProduct()
        return ProductView(product: prod)
    }
}

