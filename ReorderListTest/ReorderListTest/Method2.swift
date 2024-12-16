//
//  ContentView.swift
//  ReorderListTest
//
//  Created by Brody on 12/15/24.
//

import SwiftUI

struct ContentView2: View {
    
    @State private var episodes: [Episode] = MockData.episodes
    
    var body: some View {
        NavigationStack{
            List {
                ForEach(episodes) { episode in
                    HStack(alignment: .top, spacing: 12){
                        RoundedRectangle(cornerRadius: 12)
                            .frame(width: 80, height: 80)
                            .foregroundStyle(episode.color)
                        
                        VStack(alignment: .leading){
                            Text("Episode")
                                .font(.headline)
                            
                            Text("Here is the short description for the latest episode")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            
                        }
                    }
                }
                .onMove { indexSet, destination in
                    // moving actin itself
                    episodes.move(fromOffsets: indexSet, toOffset: destination)
                    
                    // print list order
                    for (index, episode) in episodes.enumerated() {
                        episodes[index].listOrder = index
                        print("\(episode.title), listOrder = \(index)")
                    }
                    print("-------")
                }
                .navigationTitle("Episodes")
            }
            
            


        }
    }
}

#Preview { NavigationStack{ ContentView2() } }

