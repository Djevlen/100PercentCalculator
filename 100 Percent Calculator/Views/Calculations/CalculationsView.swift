//
//  Calculations.swift
//  100 Percent Calculator
//
//  Created by Thomas Andre Johansen on 17/03/2020.
//  Copyright © 2020 Appkokeriet. All rights reserved.
//

import SwiftUI
import SwiftyJSON

struct CalculationsView: View {

    var body: some View {
        NavigationView{
            List(calculationsData){ calculationCategory in
                Text(calculationCategory.categoryTitle)
                
            }
            .navigationBarTitle("100% Percent Calculator", displayMode: .inline)
        }
    }
}

