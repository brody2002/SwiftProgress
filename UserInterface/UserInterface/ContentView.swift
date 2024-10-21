//
//  ContentView.swift
//  UserInterface
//
//  Created by Brody on 10/21/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext
    @State private var sortOrder = [
        SortDescriptor(\AddUser.name),
        SortDescriptor(\AddUser.joinDate),
    ]
    @State private var showingUpcomingOnly = false
    @State private var path = [AddUser]()
    var body: some View {
        NavigationStack(path: $path){
            UsersView(minimumJoinDate: showingUpcomingOnly ? .now : .distantPast, sortOrder: sortOrder)

            
                .navigationTitle("Users")
                .navigationDestination(for: AddUser.self) { user in
                    EditUserView(user: user)
                        
                }.toolbar {
                    
                    
                    
                    Button("Add User", systemImage: "plus") {
                        let user = AddUser(name: "", city: "", joinDate: .now)
                        modelContext.insert(user)
                        path = [user]
                    }
                    Button("Delete User", systemImage: "minus"){
                        try? modelContext.delete(model: AddUser.self)
                    }
                    Button(showingUpcomingOnly ? "Show Everyone" : "Show Upcoming") {
                        showingUpcomingOnly.toggle()
                    }
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Sort by Name")
                                .tag([
                                    SortDescriptor(\AddUser.name),
                                    SortDescriptor(\AddUser.joinDate),
                                ])

                            Text("Sort by Join Date")
                                .tag([
                                    SortDescriptor(\AddUser.joinDate),
                                    SortDescriptor(\AddUser.name)
                                ])
                        }
                    }
                    
                }
        }
    }
}

#Preview {
    ContentView()
}
