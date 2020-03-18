//
//  Calculations.swift
//  100 Percent Calculator
//
//  Created by Thomas Andre Johansen on 17/03/2020.
//  Copyright © 2020 Appkokeriet. All rights reserved.
//

import SwiftUI

struct ExampleRow: View {
    var body: some View {
        Text("Example Row")
    }
}

struct CalculationsListView: View {
    
    var body: some View {
        NavigationView{
            List(){
                ForEach(calculationsData) { category in
                    Section(header:
                        CalculationsHeader(title: category.title, isFavorite: category.isFavorite)
                    ) {
                        ForEach(category.calculations){ calc in
                            NavigationLink(destination: CalculationView(calculation: calc)) {
                                CalculationsCell(title: calc.title, isFavorite: calc.isFavorite)
                            }
                        }
                    }
                }
                
            }
            .listStyle(DefaultListStyle())
            .navigationBarTitle("100% Percent Calculator", displayMode: .inline)
        }
    }
}

