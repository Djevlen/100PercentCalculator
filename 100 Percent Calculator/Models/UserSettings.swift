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
    @Published var startingTab = "Calculations"
    
    init(data: [CalculationCategory], favoriteCalculations: [Calculation], startingTab: String) {
        self.data = data
        self.favoriteCalculations = favoriteCalculations
        self.startingTab = startingTab
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
}

//enum StartingTabs {
//    case "Favorites":
//}
