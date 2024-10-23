//
//  LearningView.swift
//  InstaFilter
//
//  Created by Brody on 10/22/24.
//

import SwiftUI

struct LearningView: View {
    @State private var blurAmount: Double = 0.0
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .blur(radius: blurAmount)
        
        Slider(value: $blurAmount, in: 0...20)
        
        Button("RandomBlur"){
            blurAmount = Double.random(in: 0...20)
        }
    }
}

#Preview {
    LearningView()
}
