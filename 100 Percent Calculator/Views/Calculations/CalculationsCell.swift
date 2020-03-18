//
//  CalculationsCell.swift
//  100 Percent Calculator
//
//  Created by Thomas Andre Johansen on 17/03/2020.
//  Copyright © 2020 Appkokeriet. All rights reserved.
//

import SwiftUI

struct CalculationsCell: View {
    var title: String
    var isFavorite: Bool
    
    #warning("Button for star")
    var body: some View {
        HStack {
            Image(systemName: isFavorite ? "star.fill" : "star")
            .foregroundColor(.yellow)
            Text(title)
            Spacer()
            
        }
    }
}
