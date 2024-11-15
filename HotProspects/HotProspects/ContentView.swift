//
//  ContentView.swift
//  HotProspects
//
//  Created by Brody on 11/15/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
            ZStack{
                TabView{
                    ProspectsView(filter: .none)
                        .tabItem{
                            Label("Everyone", systemImage: "person.3")
                        }
                    ProspectsView(filter: .uncontacted)
                        .tabItem{
                            Label("UnContacted", systemImage: "checkmark.circle")
                                
                        }
                    ProspectsView(filter: .contacted)
                        .tabItem{
                            Label("Contacted", systemImage: "questionmark.diamond")
                        }
                    MeView()
                        .tabItem{
                            Label("Me", systemImage: "person.crop.square")
                        }
                    
                }
            }
        
        
        
    }
}

#Preview {
    ContentView()
}
