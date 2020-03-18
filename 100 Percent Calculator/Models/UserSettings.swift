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
    
    func toggleFavorite(section: Int, calculationIndex: Int, calculation: Calculation) {
        self.data[section].calculations[calculationIndex].isFavorite.toggle()
        if(self.data[section].calculations[calculationIndex].isFavorite == true){
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
