//
//  UserSettings.swift
//  100 Percent Calculator
//
//  Created by Thomas Andre Johansen on 18/03/2020.
//  Copyright © 2020 Appkokeriet. All rights reserved.
//


import Combine
import SwiftUI
import StoreKit

final class UserSettings: ObservableObject {
    @Published var data = calculationsData
    @Published var favoriteCalculations: [Calculation]
    @Published var tabs = ["Calculations", "Favorites", "Settings"]
    @Published var selectedTab = "Favorites"
    @Published var useCurrency: Bool            = true
    @Published var startOnFavorites: Bool       = true
    @Published var unfavoriteTimer: Bool        = true
    @Published var restoredCalculations: Bool  = false
    
    
    @Published var isProUser: Bool              = false
    @Published var hasLoadedProducts: Bool      = false
    @Published var thankUser: Bool              = false
    @Published var favoriteLimitReached: Bool   = false
    @Published var products: [SKProduct]? = nil
    
    
    @Published var deletionWarningDismissed: Bool = false
    
    
    init(data: [CalculationCategory], favoriteCalculations: [Calculation]) {
        self.data = data
        self.favoriteCalculations = favoriteCalculations
        self.selectedTab = self.startOnFavorites ? "Favorites" : "Calculations"
        populateFavorites()
    }
    
    //puts favorites from json to favorites array
    func populateFavorites(){
        for category in self.data {
            for calculation in category.calculations {
                if(calculation.isFavorite){
                    self.favoriteCalculations.append(calculation)
                }
            }
        }
    }
    
    func toggleFavorite(calculation: Calculation){
        guard let section = self.data.firstIndex(where: {$0.calculations.contains(calculation)}) else {
            return
        }
        guard let calcIndex = self.data[section].calculations.firstIndex(where: {$0.id == calculation.id}) else {
            return
        }
        
        self.data[section].calculations[calcIndex].isFavorite.toggle()
        if(self.data[section].calculations[calcIndex].isFavorite == true){
            if self.favoriteCalculations.count >= 1 && !self.isProUser{
                self.data[section].calculations[calcIndex].isFavorite.toggle()
                self.favoriteLimitReached = true
                return
            }
            self.favoriteCalculations.append(self.data[section].calculations[calcIndex])
        }else{
            if let index = self.favoriteCalculations.firstIndex(where: { $0.id == calculation.id }) {
                self.favoriteCalculations.remove(at: index)
            }
        }
        self.save()
    }
    
    func saveDefaultOperandValue(calculation: Calculation, operands: (operand1: String, operand2: String)){
        guard let section = self.data.firstIndex(where: {$0.calculations.contains(calculation)}) else {
            return
        }
        guard let calcIndex = self.data[section].calculations.firstIndex(where: {$0.id == calculation.id}) else {
            return
        }
        if(operands.operand1.count > 0){
            self.data[section].calculations[calcIndex].defaultOperand1 = operands.operand1
        }
        if(operands.operand2.count > 0){
            self.data[section].calculations[calcIndex].defaultOperand2 = operands.operand2
        }
        self.save()
    }
    func restoreCalculations(){
        for (indexCategory, category) in self.data.enumerated() {
            for (indexCalc, calc) in self.data[indexCategory].calculations.enumerated() {
                if calc.isHidden {
                    self.data[indexCategory].calculations[indexCalc].isHidden.toggle()
                }
            }
            if category.isHidden {
                self.data[indexCategory].isHidden.toggle()
            }
        }
        self.restoredCalculations = true
    }
    
    // MARK: In-App Purchases
    func loadProducts(){
        IAPManager.shared.getProducts { (result) in
            print("getting products")
            DispatchQueue.main.async {
                switch result{
                case .success(let products):
                    if self.isProUser{
                        self.products = products.filter {!$0.productIdentifier.lowercased().contains("pro")}
                        print("proUser er true, products er: \(String(describing: self.products))")
                        
                    }else {
                        self.products = products
                        print("proUser er false, products er: \(String(describing: self.products))")
                    }
                    self.hasLoadedProducts = true
                case .failure(let error):
                    print("error: \(error)")
                }
            }
        }
    }
    
    func productPurchased(_ product: SKProduct){
        print("the user bought this: \(product.localizedTitle)")
        self.thankUser = true
        if product.productIdentifier.lowercased().contains("pro"){
            self.isProUser = true
            self.hasLoadedProducts = false
        }
    }
    
    // MARK: Saving JSON
    func save(){
        let encoder = JSONEncoder()
        let url = self.getDocumentsDirectory().appendingPathComponent("PersonalCalculationsData.json")
        
        if let encoded = try? encoder.encode(self.data) {
            if let json = String(data: encoded, encoding: .utf8) {
                do {
                    try json.write(to: url, atomically: true, encoding: .utf8)
                    print("tried to write!!")
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        // just send back the first one, which ought to be the only one
        return paths[0]
    }
    
}
