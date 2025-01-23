//
//  ContentView.swift
//  StaticLibAppTest
//
//  Created by Brody on 1/23/25.
//

import SwiftUI
import StaticLibTest

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear{
            StaticLibTest.StaticLibClass.staticLibPrint("HELLO")
            // Doesn't work for the preview for some reason
            // Works for actual simulator though...
            
            
        }
    }
}

#Preview {
    ContentView()
}

