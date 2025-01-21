//
//  SwiftUIReviewJanApp.swift
//  SwiftUIReviewJan
//
//  Created by Brody on 1/21/25.
//

import SwiftUI

@main
struct SwiftUIReviewJanApp: App {
    @AppStorage("loadShoes") private var loadShoes: Bool = true
    var body: some Scene {
        WindowGroup {
            ContentView(loadShoes: $loadShoes)
                .modelContainer(for: Shoe.self)
        }
    }
}
