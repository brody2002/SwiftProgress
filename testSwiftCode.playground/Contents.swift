import UIKit
import SwiftUI
var greeting = "Hello, playground"


private var testString = "hello"

for (index, element) in testString.enumerated(){
    print("index: \(index), element: \(element)")
}

print(Array(testString)[4])
