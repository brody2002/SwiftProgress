//
//  DetailShoeView.swift
//  SwiftUIReviewJan
//
//  Created by Brody on 1/21/25.
//

import SwiftUI

struct DetailShoeView: View {
    @State var shoeObject: Shoe
    
    var body: some View {
        VStack(alignment: .center){
            Text("Traction: \(shoeObject.traction)")
            Text("Cushion: \(shoeObject.cushion)")
            Text("Style: \(shoeObject.style)")
        }
        .fontDesign(.rounded)
        .bold()
        .navigationTitle("\(shoeObject.name)")
    }
}
