//
//  BookLibraryApp.swift
//  BookLibrary
//
//  Created by Brody on 10/21/24.
//

import SwiftUI

@main
struct BookLibraryApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
