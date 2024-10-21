//
//  NavigationHandlingApp.swift
//  NavigationHandling
//
//  Created by Brody on 10/15/24.
//
import SwiftData
import SwiftUI

@main
struct NavigationHandlingApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(for: PersonClass.self)
    }
}
