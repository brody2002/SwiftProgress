//
//  SwiftDataTestApp.swift
//  SwiftDataTest
//
//  Created by Brody on 10/21/24.
//

import SwiftUI

@main
struct SwiftDataTestApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        
        .modelContainer(for: PersonClass.self)
    }
}
