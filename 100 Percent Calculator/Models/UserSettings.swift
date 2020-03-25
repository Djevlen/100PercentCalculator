//
//  UserSettings.swift
//  100 Percent Calculator
//
//  Created by Thomas Andre Johansen on 18/03/2020.
//  Copyright © 2020 Appkokeriet. All rights reserved.
//


import Combine
import SwiftUI

final class UserSettings: ObservableObject {
    @Published var data = calculationsData
    @Published var favoriteCalculations: [Calculation]
    @Published var tabs = ["Calculations", "Favorites", "Settings"]
    @Published var selectedTab = "Favorites"
    @Published var useCurrency: Bool = true
    @Published var startOnFavorites: Bool = true
    
    @Published var deletionWarningDismissed: Bool = false
    
    
    init(data: [CalculationCategory], favoriteCalculations: [Calculation]) {
        self.data = data
        self.favoriteCalculations = favoriteCalculations
        self.selectedTab = self.startOnFavorites ? "Favorites" : "Calculations"
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
    }
    
    
}
