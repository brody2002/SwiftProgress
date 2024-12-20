//
//  Drag.swift
//  AnimationsLearning
//
//  Created by Brody on 11/15/24.
//

import SwiftUI

struct Drag: View {
    
    
    
    
    
    @Environment(\.scenePhase) var scenePhase
    
    
    
    
    
    
    // how far the circle has been dragged
    @State private var offset = CGSize.zero

    // whether it is currently being dragged or not
    @State private var isDragging = false

    var body: some View {
        // a drag gesture that updates offset and isDragging as it moves around
        
        
        
        
        
        
        
        let dragGesture = DragGesture()
            .onChanged { value in offset = value.translation }
            .onEnded { _ in
                withAnimation {
                    offset = .zero
                    isDragging = false
                }
            }

        // a long press gesture that enables isDragging
        let pressGesture = LongPressGesture(minimumDuration: 0.4)
            .onEnded { value in
                withAnimation {
                    isDragging = true
                }
            }

        // a combined gesture that forces the user to long press then drag
        let combined = pressGesture.sequenced(before: dragGesture)

        // a 64x64 circle that scales up when it's dragged, sets its offset to whatever we had back from the drag gesture, and uses our combined gesture
        Circle()
            .fill(.red)
            .frame(width: 64, height: 64)
            .scaleEffect(isDragging ? 1.5 : 1)
            .offset(offset)
            .gesture(combined)
            .onChange(of:scenePhase){ oldValue, newValue in
                if newValue == .active{
                    print("in active view")
                }
                else if newValue == .inactive{
                    print("inactive view")
                }
                else{
                    print("background view")
                }
            }
    }
}

#Preview {
    Drag()
}
