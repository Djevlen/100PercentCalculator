//
//  ResultView.swift
//  100 Percent Calculator
//
//  Created by Thomas Andre Johansen on 19/03/2020.
//  Copyright © 2020 Appkokeriet. All rights reserved.
//

import SwiftUI

struct ResultView: View{
    @Binding var operand1: String
    @Binding var operand2: String
    @ObservedObject var calculator = Calculator(result: ("",""))
    
    @State private var result: String = ""
    @State private var additionalResult: String = ""
    @State private var showAdditionalInfo = false
    @State private var calculationOk = false

    var calculation: Calculation
    
    var resultString: String {
        return self.calculation.resultString
    }
    var additionalString: String {
        return self.calculation.additionalString
    }
    
    func checkCalculation() -> Bool{
        if self.operand1.count > 0 && self.operand2.count > 0 {
            return true
        }
        return false
    }
    
    func calculate(){
        guard checkCalculation() else{
            return
        }
        
        
    }
    
    func performCalculation() -> String{
        guard let operand1 = Double(self.operand1), let operand2 = Double(self.operand2) else{
            calculationOk.toggle()
            return "Begge nummer må være tall!"
        }
        let result = operand1 * operand2
        
        showAdditionalInfo = true
        return "\(result)"
    }
    
    func testObserved(){
    }


    var body: some View{
        VStack{
            if(checkCalculation()){
                
                Text(performCalculation())
                Button(action: {
                    self.testObserved()
                }) {
                    Text("we")
                }
            }else{
                
            }
            
        }
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(operand1: .constant("50"), operand2: .constant(("40")), calculation: calculationsData[0].calculations[0] )
    }
}
