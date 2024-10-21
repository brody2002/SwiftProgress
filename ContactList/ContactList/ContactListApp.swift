//
//  ContactListApp.swift
//  ContactList
//
//  Created by Brody on 10/21/24.
//

import SwiftUI

@main
struct ContactListApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(for: Contact.self)
    }
}
