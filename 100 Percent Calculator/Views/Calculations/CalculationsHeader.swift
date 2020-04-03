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
    
    var body: some View {
        HStack{
            Text(title)
                .font(.headline)
        }
    }
}
