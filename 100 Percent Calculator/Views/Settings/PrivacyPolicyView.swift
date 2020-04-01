//
//  PrivacyPolicyView.swift
//  100 Percent Calculator
//
//  Created by Thomas Andre Johansen on 25/03/2020.
//  Copyright © 2020 Appkokeriet. All rights reserved.
//

import SwiftUI

struct PrivacyPolicyView: View {
    var body: some View {
        VStack {
                Text("Privacy is very important to me, and is taken very seriously. In this app I do not collect any of your identifiable data, nor sell, rent or give away any information regarding your use of the 100% app.")
                    .font(.headline)
                    .padding()
                Text("Apple provides developers with anonymous information intended to help developers make the apps be the best apps they can be. In addition to this I've implemented Firebase Analytics (made by Google) to collect anonymous user behaviour. This helps me understand how the app is being used, is completely anonymous and can not be tracked to individual users. The Firebase Privacy Policy can be found at https://firebase.google.com/support/privacy")
                    .font(.body)
                    .padding()
                Spacer()
        
        .navigationBarTitle(Text("Privacy Policy"))
        }
    }
}

struct PrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicyView()
    }
}
