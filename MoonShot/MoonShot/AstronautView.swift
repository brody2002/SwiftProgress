//
//  AstronautView.swift
//  MoonShot
//
//  Created by Brody on 10/15/24.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    
    var body: some View {
        ScrollView{
            VStack{
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                
                Text(astronaut.description)
                    .padding()
                
            }
            
        }
        .background(.darkBackground)
        
    }
}

#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    AstronautView(astronaut: astronauts["aldrin"]!)
}
