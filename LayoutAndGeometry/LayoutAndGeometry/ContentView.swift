//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Brody on 11/18/24.
//

import SwiftUI

extension VerticalAlignment {
    struct MidAccountAndName: AlignmentID {
        // Default alignment
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.top]
        }
    }

    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}

struct ContentView: View {
    
    var body: some View {
        HStack(alignment: .midAccountAndName) {
            VStack {
                Text("BrewMaster")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                Image("brewMaster")
                    .resizable()
                    .frame(width: 64, height: 64)
            }

            VStack {
                Text("Full name:")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                    
                Text("Brody Roberts")
                    
                    .font(.largeTitle)
            }
        }
        Spacer()
            .frame(height: 60)
        HStack(alignment: .midAccountAndName){
            VStack{
                Text("Testing")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
            }
            
            VStack{
                Text("Sarah")
                    
                Image("brewMaster")
                    .resizable()
                    .frame(width: 100, height: 50)
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                    
                    
                
                    
            }
            
        }

    }
}

#Preview {
    ContentView()
}
