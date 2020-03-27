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
    @Published var useCurrency: Bool = true
    @Published var startOnFavorites: Bool = true
    @Published var unfavoriteTimer: Bool = true
    
    //iap values
    @Published var iapProductsLoaded: Bool = false
    @Published var iapProducts: [SKProduct]? = nil
    
    @Published var deletionWarningDismissed: Bool = false
    
    
    init(data: [CalculationCategory], favoriteCalculations: [Calculation]) {
        self.data = data
        self.favoriteCalculations = favoriteCalculations
        self.selectedTab = self.startOnFavorites ? "Favorites" : "Calculations"
        IAPManager.shared.getProducts { (result) in
            print("getting products")
            self.iapProductsLoaded = true

            switch result{
            case .success(let products): self.iapProducts = products
            case .failure(let error): print("error: \(error)")
            }
        }
    }
    
    func toggleFavoriteFromCalculation(calculation: Calculation){
        guard let section = self.data.firstIndex(where: {$0.calculations.contains(calculation)}) else {
            return
        }
        guard let calcIndex = self.data[section].calculations.firstIndex(where: {$0.id == calculation.id}) else {
            return
        }
        self.data[section].calculations[calcIndex].isFavorite.toggle()
        if(self.data[section].calculations[calcIndex].isFavorite == true){
            self.favoriteCalculations.append(calculation)
        }else{
            if let index = self.favoriteCalculations.firstIndex(where: { $0.id == calculation.id }) {
                self.favoriteCalculations.remove(at: index)
            }
        }
    }
    
    func saveDefaultOperandValue(calculation: Calculation, operands: (operand1: String, operand2: String)){
        guard let section = self.data.firstIndex(where: {$0.calculations.contains(calculation)}) else {
            return
        }
        guard let calcIndex = self.data[section].calculations.firstIndex(where: {$0.id == calculation.id}) else {
            return
        }
        if(operands.operand1.count > 0 && operands.operand1 != nil){
            self.data[section].calculations[calcIndex].defaultOperand1 = operands.operand1
        }
        if(operands.operand2.count > 0 && operands.operand2 != nil){
            self.data[section].calculations[calcIndex].defaultOperand2 = operands.operand2
        }
        
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
    }
}
