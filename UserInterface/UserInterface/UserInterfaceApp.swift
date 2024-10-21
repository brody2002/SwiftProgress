//
//  UserInterfaceApp.swift
//  UserInterface
//
//  Created by Brody on 10/21/24.
//

import SwiftUI

@main
struct UserInterfaceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: AddUser.self)
    }
}


