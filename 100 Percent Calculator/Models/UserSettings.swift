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
    @Published var compactFavorites: Bool       = true
    @Published var restoredCalculations: Bool   = false
    @Published var restoredCalculationsCount: Int = 0
    
    @Published var isProUser: Bool              = false
    @Published var hasLoadedProducts: Bool      = false
    @Published var favoriteLimitReached: Bool   = false

    
    
    init(data: [CalculationCategory], favoriteCalculations: [Calculation]) {
        self.data = data
        self.favoriteCalculations = favoriteCalculations
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
        let favorite = self.favoriteCalculations.firstIndex(of: calculation)
        if favorite != nil {
            self.favoriteCalculations[favorite!].defaultOperand1 = operands.operand1.count > 0 ? operands.operand1 : nil
            self.favoriteCalculations[favorite!].defaultOperand2 = operands.operand2.count > 0 ? operands.operand2 : nil
        }
        self.data[section].calculations[calcIndex].defaultOperand1 = operands.operand1.count > 0 ? operands.operand1 : nil
        self.data[section].calculations[calcIndex].defaultOperand2 = operands.operand2.count > 0 ? operands.operand2 : nil
        
        self.save()
    }
    
    func resetDefaultOperandValues(for calculation: Calculation){
        guard let section = self.data.firstIndex(where: {$0.calculations.contains(calculation)}) else {
            return
        }
        guard let calcIndex = self.data[section].calculations.firstIndex(where: {$0.id == calculation.id}) else {
            return
        }
        let favorite = self.favoriteCalculations.firstIndex(of: calculation)
        if favorite != nil {
            self.favoriteCalculations[favorite!].defaultOperand1 = nil
            self.favoriteCalculations[favorite!].defaultOperand2 = nil
            
        }
        self.data[section].calculations[calcIndex].defaultOperand1 = nil
        self.data[section].calculations[calcIndex].defaultOperand2 = nil
    }
    
    func restoreCalculations(){
        var count: Int = 0
        for (indexCategory, category) in self.data.enumerated() {
            for (indexCalc, calc) in self.data[indexCategory].calculations.enumerated() {
                if calc.isHidden {
                    count += 1
                    self.data[indexCategory].calculations[indexCalc].isHidden.toggle()
                }
            }
            if category.isHidden {
                self.data[indexCategory].isHidden.toggle()
            }
        }
        self.restoredCalculationsCount = count
        self.restoredCalculations = true
    }
    
    
    
    // MARK: Saving JSON
    func save(){
        let encoder = JSONEncoder()
        let url = self.getDocumentsDirectory().appendingPathComponent("UserEditedCalculationsData.json")
        
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
