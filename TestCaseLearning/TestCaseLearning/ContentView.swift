//
//  ContentView.swift
//  TestCaseLearning
//
//  Created by Brody on 12/16/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

struct Calculator {
    
    func BrodyAddition<T: Comparable & Numeric>(_ number1: T, _ number2: T) -> T{
        return number1 + number2
    }
}
