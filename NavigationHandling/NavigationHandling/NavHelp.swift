//
//  ContentView.swift
//  NavigationHandling
//
//  Created by Brody on 10/15/24.
//

import SwiftUI

struct NavHelp: View {
    
    struct Student: Hashable{
        var id = UUID()
        var name: String
        var age: Int
    }
    
    var body: some View {
        NavigationStack{
            NavigationLink("NAME EXAMPLE", value: Student(name: "brody roberts", age: 22))
            List(0..<100) {i in
                NavigationLink("select \(i)", value: i)
                
            }
            .navigationDestination(for: Int.self) {selection in
                    Text("You selected \(selection)")
            }
            .navigationDestination(for: Student.self) {student in
                Text("You selected \(student.name)")
            }
        }
    }
}

#Preview {
    NavHelp()
}

