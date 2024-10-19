//
//  ContentView.swift
//  AnimationsLearning
//
//  Created by Brody on 10/11/24.
//

import SwiftUI

struct scaleInf: View {
    @State private var animationAmount = 1.0
    var body: some View {
            Button("Tap Me") {
                animationAmount += 1
            }
            .padding(50)
            .background(.red)
            .foregroundStyle(.white)
            .clipShape(.circle)
            .scaleEffect(animationAmount)
            .animation(.easeInOut(duration: 2), value: animationAmount)
        }
}

struct pulseView: View {
    @State private var animationAmount = 1.0
    @State private var tapped: Bool = false

    @State private var animationAmount2 = 0.0
    
    var body: some View {
        VStack{
            Spacer()
            Button("Tap Me") {
            }
            .padding(50)
            .background(.indigo.gradient)
            .foregroundStyle(.white)
            .clipShape(.circle)
            .overlay(
                Circle()
                    .stroke(.green)
                    .scaleEffect(animationAmount)
                    .opacity(2 - animationAmount)
                    .animation(
                        .easeInOut(duration: 1)
                            .repeatForever(autoreverses: false),
                        value: animationAmount
                    )
            )
            .onAppear {
                animationAmount = 2
            }
            Spacer()
            
            Button("Tap Me") {
                withAnimation{
                    animationAmount+=180
                    
                }
                    }
                    .padding(50)
                    .background(.red)
                    .foregroundStyle(.white)
                    .clipShape(.circle)
                    .rotation3DEffect(.degrees(animationAmount), axis: (x: 1, y: 1, z: 0))
            
            
            Spacer()
        }
    }
        
}

#Preview {
    pulseView()
}
