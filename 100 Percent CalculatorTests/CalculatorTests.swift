//
//  CalculatorTest.swift
//  100 Percent CalculatorTests
//
//  Created by Thomas Andre Johansen on 24/04/2020.
//  Copyright © 2020 Appkokeriet. All rights reserved.
//

import XCTest
@testable import OneHundredPercent

class CalculatorTests: XCTestCase {
    var calculator: Calculator!
    var operand1: String = ""
    var operand2: String = ""
    

    override func setUp(){
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        calculator = Calculator()
        operand1 = "100"
        operand2 = "10"

    }

    override func tearDown(){
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        calculator = nil
        super.tearDown()

    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        //
    }
    
    func testCalculatorDotifyInput() {
        //given
        var string = "5,5"
        //when
        string = calculator.dotify(string)
        //then
        XCTAssert(string.contains("."), "String does not contain dot!")
    }
    
    func testCalculatorCanCalculate() {
        
        XCTAssert(calculator.canCalculate(operand1: operand1, operand2: operand2), "Calculator can't calculate two strings")
    }
    
    func testPerformCalculation(){
        let randomCalculation = calculationsData.randomElement()!.calculations.randomElement()!.calcToPerform
        calculator.performCalculation(calcToPerform: randomCalculation, operand1: operand1, operand2: operand2)
        XCTAssert(calculator.result.count > 0, "Calculation was not performed!")
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
