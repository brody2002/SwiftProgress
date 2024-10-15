//
//  ContentView.swift
//  MoonShot
//
//  Created by Brody on 10/15/24.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    let columns = [
        //Controls Width of Columns
        GridItem(.adaptive(minimum: 150))
    ]
    @State private var listMode: Bool = true
    
    
    var body: some View {
        NavigationStack {
                if listMode{
                    ZStack{
                        Color.darkBackground.ignoresSafeArea()
                        VStack{
                            Text("ToggleView")
                                .padding(20)
                                .background(.lightBackground)
                                .cornerRadius(20)
                                .onTapGesture {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.4)){
                                        listMode.toggle()
                                    }
                                }
                            
                            List {
                                ForEach(missions) {mission in
                                    NavigationLink {
                                        MissionView(mission: mission, astronauts: astronauts)
            
                                    } label: {
                                        VStack {
                                            Image(mission.image)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width:100, height:100)
                                                .padding()
                                            VStack{
                                                Text(mission.displayName)
                                                    .font(.headline)
                                                    .foregroundStyle(.white)
                                                    .bold()
            
                                                Text(mission.formattedLaunchDate)
                                                    .font(.caption)
                                                    .foregroundStyle(.white)
                                            }.padding(.vertical)
                                                .frame(maxWidth: .infinity)
                                                .background(.lightBackground)
                                        }
                                        .clipShape(.rect(cornerRadius: 10))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(.lightBackground)
                                        )
            
                                    }
                                    
                                }.background(.darkBackground)
                                    .preferredColorScheme(.dark)
                            }
                            .frame(width: .infinity)
                            
                            .navigationTitle("Moonshot")
                            
                        }
                    }
                    
                } else{
                    
                    ScrollView{
                        Text("ToggleView")
                            .padding(20)
                            .background(.lightBackground)
                            .cornerRadius(20)
                            .onTapGesture {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.4)){
                                    listMode.toggle()
                                }
                            }
                    LazyVGrid(columns: columns) {
                        ForEach(missions) {mission in
                            NavigationLink {
                                MissionView(mission: mission, astronauts: astronauts)
                                
                            } label: {
                                VStack {
                                    Image(mission.image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width:100, height:100)
                                        .padding()
                                    VStack{
                                        Text(mission.displayName)
                                            .font(.headline)
                                            .foregroundStyle(.white)
                                            .bold()
                                        
                                        Text(mission.formattedLaunchDate)
                                            .font(.caption)
                                            .foregroundStyle(.white)
                                    }.padding(.vertical)
                                        .frame(maxWidth: .infinity)
                                        .background(.lightBackground)
                                }
                                .clipShape(.rect(cornerRadius: 10))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.lightBackground)
                                )
                                
                            }
                        }
                    }
                    .padding([.horizontal, .bottom])
                }
                    .navigationTitle("Moonshot")
                    .background(.darkBackground)
                    .preferredColorScheme(.dark)
                    
                }
                
            }
                
        }
    }


#Preview {
    ContentView()
}
