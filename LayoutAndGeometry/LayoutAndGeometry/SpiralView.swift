//
//  SpiralView.swift
//  LayoutAndGeometry
//
//  Created by Brody on 11/18/24.
//

import SwiftUI

struct SpiralView: View {
    let colors: [Color] = [.blue, .gray, .blue, .pink, .gray.opacity(0.7), .blue.opacity(0.7), .teal]

    var body: some View {
        GeometryReader { fullView in
            ScrollView {
                ForEach(0..<50) { index in
                    GeometryReader { proxy in
                        Text("Row #\(index)")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            .background(colors[index % 7])
                            .rotation3DEffect(.degrees(proxy.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
                    }
                    .frame(height: 40)
                }
            }
        }
    }
}

#Preview {
    SpiralView()
}
