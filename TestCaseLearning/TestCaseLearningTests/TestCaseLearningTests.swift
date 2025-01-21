//
//  TestCaseLearningTests.swift
//  TestCaseLearningTests
//
//  Created by Brody on 12/16/24.
//

import Testing
@testable import TestCaseLearning
import XCTest

struct TestCaseLearningTests {
    let calc = Calculator()
    @Test func testBrodyAddition() {
        
        let value1 = 3
        let value2 = 4
        let answer = 7
        
        
        
        XCTAssertEqual(answer, calc.BrodyAddition(value1, value2))

    }
    
    @Test func testFloat() {
        let value1 = 3.0
        let value2 = -22.0
        let answer = -19.0
        XCTAssertEqual(answer, calc.BrodyAddition(value1, value2))
    }
    
}
