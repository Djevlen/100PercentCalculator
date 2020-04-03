//
//  Calculations.swift
//  100 Percent Calculator
//
//  Created by Thomas Andre Johansen on 17/03/2020.
//  Copyright © 2020 Appkokeriet. All rights reserved.
//

import SwiftUI

struct CalculationsListView: View {
    @EnvironmentObject var userSettings: UserSettings
    
    var body: some View {
        NavigationView{
            List(){
                ForEach(self.userSettings.data) { category in
                    if(category.isHidden == false){
                        Section(header:
                            CalculationsHeader(title: category.title)
                        ) {
                            ForEach(category.calculations){ calc in
                                if(calc.isHidden == false){
                                    NavigationLink(destination: CalculationHost(calculation: calc)) {
                                        CalculationsCell(calculation: calc, section: self.getSection(from: category))
                                    }
                                }
                            }
                            .onDelete{self.hideCalculation(at: $0, in: category) }
                            
                        }
                        
                    }
                    
                }
                
                
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("100% Percent Calculator", displayMode: .inline)
            .navigationBarItems(trailing: EditButton())
        }
        .sheet(isPresented: self.$userSettings.favoriteLimitReached) {
            iAPSheetView(isPresenting: self.$userSettings.favoriteLimitReached).environmentObject(self.userSettings)
        }
    }
    
    
    func getSection(from category: CalculationCategory) -> Int{
        return self.userSettings.data.firstIndex(of: category)!
    }
    
    func hideCalculation(at offsets: IndexSet, in category: CalculationCategory){
        let section = self.getSection(from: category)
        self.userSettings.data[section].calculations[offsets.first!].isHidden = true
        
        if (self.userSettings.data[section].calculations.allSatisfy({$0.isHidden == true})) {
            self.userSettings.data[section].isHidden = true
        }
    }
}

