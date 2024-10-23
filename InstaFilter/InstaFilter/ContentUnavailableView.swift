//
//  ContentUnavailableView.swift
//  InstaFilter
//
//  Created by Brody on 10/22/24.
//

import SwiftUI

struct MyContentUnavailableView: View {
    var body: some View {
        ContentUnavailableView {
            Label("No snippets", systemImage: "swift")
        } description: {
            Text("You don't have any saved snippets yet.")
        } actions: {
            Button("Create Snippet") {
                // Add logic to create a snippet
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    MyContentUnavailableView()
}
