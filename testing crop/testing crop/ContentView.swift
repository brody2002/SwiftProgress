import SwiftUI
import AVFoundation

// Circles and Lines View
struct CircleBoundaryView: View {
    @Binding var points: [CGPoint]

    var body: some View {
        ZStack {
            // Draw lines between neighboring circles
            Path { path in
                for index in points.indices {
                    let point1 = points[index]
                    let point2 = points[(index + 1) % points.count] // Connect back to the first circle

                    if index == 0 {
                        path.move(to: point1)
                    }
                    path.addLine(to: point2)
                }
            }
            .stroke(Color.black, lineWidth: 3)
            .zIndex(1.0)

            // Place circles
            ForEach(points.indices, id: \.self) { index in
                CroppingCircle(point: $points[index])
                    .position(points[index])
                    .zIndex(2.0)
            }
        }
    }
}

// Circles
struct CroppingCircle: View {
    @Binding var point: CGPoint

    var body: some View {
        ZStack {
            Circle()
                .fill(Color.black)
                .frame(width: 20, height: 20)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            // Directly update the point during drag to make it smoother
                            point.x += value.translation.width
                            point.y += value.translation.height
                        }
                )
        }
    }
}

// Preview View
struct CircleBoundaryPreview: View {
    @State var points: [CGPoint] = [
        CGPoint(x: 150, y: 200), // L top Corner
        CGPoint(x: 250, y: 200), // R top corner
        CGPoint(x: 250, y: 400), // R bot corner
        CGPoint(x: 150, y: 400)  // L bot corner
    ]

    var body: some View {
        CircleBoundaryView(points: $points)
            .zIndex(2.0)
    }
}

#Preview {
    CircleBoundaryPreview()
}

