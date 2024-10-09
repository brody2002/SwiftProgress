//
//  AlertView.swift
//  GuessTheFlag
//
//  Created by Brody on 10/8/24.
//

import SwiftUI

struct AlertView: View {
    @State private var testAlert: Bool = false
    
    var body: some View {
        Button("hello"){
            testAlert.toggle()
        }.alert("Important Message", isPresented: $testAlert){
            Button("Okay") {}
        }// isPresented is automatically set back to false after alert is dimissed
    }
}

#Preview {
    AlertView()
}
