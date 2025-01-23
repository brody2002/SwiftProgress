//
//  StatiLibTest.swift
//  StatiLibTest
//
//  Created by Brody on 1/23/25.
//

public class StaticLibClass {
    public var value1: Int
    public var value2: Int
    public static func staticLibPrint(_ input: String){
        print("This is the inputed string: \(input)")
    }
    public init(value1: Int = 10, value2: Int = 2) {
        self.value1 = value1
        self.value2 = value2
    }
    
}
