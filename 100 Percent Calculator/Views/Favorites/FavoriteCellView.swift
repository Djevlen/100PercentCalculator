//
//  FavoriteCellView.swift
//  100 Percent Calculator
//
//  Created by Thomas Andre Johansen on 19/03/2020.
//  Copyright © 2020 Appkokeriet. All rights reserved.
//

import SwiftUI

struct FavoriteCellView: View {
    var favorite: Calculation
    
    var body: some View {
        HStack{
            Text(favorite.title)
            Spacer()
            
        }
        
    }
}

struct FavoriteCellView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteCellView(favorite: calculationsData[0].calculations[0])
    }
}
