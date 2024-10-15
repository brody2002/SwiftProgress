//
//  ContentView.swift
//  NavigationHandling
//
//  Created by Brody on 10/15/24.
//

import SwiftUI


struct TestView1: View {
    var body: some View {
        ZStack {
            Color.red
                .ignoresSafeArea()
            Text("Red View")
                .foregroundColor(.white)
                .font(.largeTitle)
        }
    }
}

struct TestView2: View {
    var body: some View {
        ZStack {
            Color.green
                .ignoresSafeArea()
            Text("Green View")
                .foregroundColor(.white)
                .font(.largeTitle)
        }
    }
}


enum Destination: Hashable {
    case redView
    case greenView
}

struct ContentView: View {
    @State private var path = [Destination]()

    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 20) {
                Button("Go Red") {
                    path.append(.redView)
                }
                
                Button("Go Green") {
                    path.append(.greenView)
                }
            }
            .navigationDestination(for: Destination.self) { destination in
                switch destination {
                case .redView:
                    TestView1()
                case .greenView:
                    TestView2()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

