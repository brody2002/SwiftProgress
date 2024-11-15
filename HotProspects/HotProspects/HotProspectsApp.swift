//
//  HotProspectsApp.swift
//  HotProspects
//
//  Created by Brody on 11/15/24.
//

import SwiftUI
import SwiftData

@main
struct HotProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                
        }.modelContainer(for: Prospect.self)
    }
}
