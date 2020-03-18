//
//  CalculationsHeader.swift
//  100 Percent Calculator
//
//  Created by Thomas Andre Johansen on 17/03/2020.
//  Copyright © 2020 Appkokeriet. All rights reserved.
//

import SwiftUI

struct CalculationsHeader: View {
    var title: String
    var isFavorite: Bool
    
    #warning("The star needs to be a button, toggling isFavorite, if sections should be favoritable")
    var body: some View {
        HStack{
            Text(title)
//            Spacer()
//            Image(systemName: isFavorite ? "star.fill" : "star")
//                .foregroundColor(.yellow)
        }
    }
}
