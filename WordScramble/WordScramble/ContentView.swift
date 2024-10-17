//
//  ContentView.swift
//  WordScramble
//
//  Created by Brody on 10/10/24.
//



//Learning View for tutorials
import SwiftUI

struct ContentView: View {
    private var homies = ["Isaiah", "Ryan", "Kurtis", "Alex", "David", "Joey", "Luke", "Josh", "Joaq", "Guy", "Brody"].shuffled()
    func testStrings(){
        let testString = "a b c d "
        let testArray = testString.components(separatedBy: " ")
        print(testArray)
    }
    func spellCheck() -> Bool{
        let word = "Swiftdd"
        
        //Bridge to UIKit
        let checker = UITextChecker()
        
        
        
        //range of utf16 characters for emjois also
        let range = NSRange(location: 0, length: word.utf16.count)
        //Checks for misspellings
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        let allGood = misspelledRange.location == NSNotFound
        
        return allGood
    }
    var body: some View {
        List(homies, id: \.self){
            if $0 == "Brody"{
                Text("\($0) plus tapGesture")
                    .onTapGesture {
                        testStrings()
                        print(homies.randomElement() ?? "Unknown homie")
                        print(spellCheck())
                    }
            } else{
                Text($0)
            }
            
        }
    }
}

#Preview {
    ContentView()
}
