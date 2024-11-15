//
//  ViewTesting.swift
//  AnimationsLearning
//
//  Created by Brody on 10/28/24.
//

import Foundation
import SwiftUI


struct TestingView: View {
    
    // States to control the animation
    @State private var isAnimatingVertically = false
    @State private var isAnimatingHorizontally = false
    
    @State var color: Color
    
    let height: CGFloat = 120
    
    init(color: Color) {
       self.color = color
    }
    
    var body: some View {
       VStack {
          Rectangle()
             .fill(color)
             .frame(width: height, height: height)
             .rotation3DEffect(.degrees(isAnimatingVertically ? 180 : 0), axis: (x: 1, y: 0, z: 0))
             .animation(Animation.linear(duration: 1).delay(1).repeatForever(autoreverses: false), value: UUID())
             .rotation3DEffect(.degrees(isAnimatingHorizontally ? 180 : 0), axis: (x: 0, y: 1, z: 0))
             .animation(Animation.linear(duration: 1).delay(1).repeatForever(autoreverses: false), value: UUID())
       }
       .onAppear {
          isAnimatingVertically = true

          // Adding a delay to ensure the completion of the first rotation
          DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
              isAnimatingHorizontally = true
          }
       }
    }
}

struct ThreeTriangleRotatingDots: View {
    
    // State variable to control the animation
    @State var isAnimating: Bool = false
    
    @State var color: Color
    
    // Constants to configure the dots
    private let height: CGFloat = 40
    
    // Initializer to set the dot color
    init(color: Color) {
        self.color = color
    }
    
    var body: some View {
        ZStack {
            // Circles forming a triangular pattern
            Circle()
                .fill(color)
                .offset(x: 0, y: isAnimating ? -height : 0)
            
            Circle()
                .fill(color)
                .offset(x: isAnimating ? -height : 0, y: isAnimating ? height : 0)
            
            Circle()
                .fill(color)
                .offset(x: isAnimating ? height : 0, y: isAnimating ? height : 0)
        }
        .frame(height: height)
        // Animation for the triangular movement
        .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true), value: UUID())
        // Rotation animation for an overall spinning effect
        .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
        .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: false), value: UUID())
        .onAppear {
            isAnimating = true
        }
    }
}


#Preview {
    ZStack{
        Color.red.ignoresSafeArea()
        TestingView(color: Color.indigo)
        ThreeTriangleRotatingDots(color: Color.white)
            
    }
    
}
