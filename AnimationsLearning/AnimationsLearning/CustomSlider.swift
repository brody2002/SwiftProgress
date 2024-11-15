import SwiftUI

struct Bar: View {
    @State private var capsuleWidthStart: CGFloat = 0
    @State private var capsuleWidthEnd: CGFloat = 30
    var totalWidth = UIScreen.main.bounds.width - 60
    
    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                // Background track
                Rectangle()
                    .fill(Color.black.opacity(0.2))
                    .frame(height: 6)
            
                
                Rectangle()
                    .fill(Color.black)
                    .frame(width: self.capsuleWidthEnd - self.capsuleWidthStart + 20, height: 6)
                    .offset(x: self.capsuleWidthStart)
                    
                    
                
                HStack {
                    Capsule()
                        .frame(width: 14, height: 28)
                        .offset(x: capsuleWidthStart - 5)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    if value.location.x >= 0 && value.location.x <= self.capsuleWidthEnd{
                                        self.capsuleWidthStart = value.location.x
                                    }
                                }
                        )
                    
                    Capsule()
                        .frame(width: 14, height: 28)
                        .offset(x: capsuleWidthEnd - 5)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    if value.location.x <= self.totalWidth + 10 && value.location.x >= self.capsuleWidthStart{
                                        self.capsuleWidthEnd = value.location.x
                                    }
                                }
                        )
                }
                
            }.padding()
        }
        
        
    }
}

struct CustomSlider: View {
    var body: some View {
        Bar()
            .frame(height: 10)
    }
}

#Preview {
    CustomSlider()
}

