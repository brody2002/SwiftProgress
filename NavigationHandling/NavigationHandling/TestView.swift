import SwiftUI

struct TestView: View {
    @State private var mainNavPath = NavigationPath()

    var body: some View {
        NavigationStack(path: $mainNavPath) {
            ZStack{
                LinearGradient(
                                    gradient: Gradient(colors: [Color.yellow, Color.orange]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                                .ignoresSafeArea()
                NavigationLink("Entrance to next view:", value: "TestView1")
                
                // Define a navigation destination
                .navigationDestination(for: String.self) { value in
                    if value == "TestView1"{
                        window(mainNavPath: $mainNavPath)
                    }
                      
                    if value == "view 3" {
                        view3(mainNavPath: $mainNavPath) // Navigate to the third view
                    }
                
                }
            }
            
        }
    }
}

struct window: View {
    @Binding var mainNavPath: NavigationPath
    
    var body: some View {
        ZStack {
            Color.red.ignoresSafeArea()
            VStack {
                Text("You're in the new view")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                
                Text("Print the Path: Tap me")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
                    .onTapGesture {
                        print("Navigation Path: \(mainNavPath)")
                    }
                
                NavigationLink("Tap again to go to greenView", value: "view 3")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
                    .padding(.top, 300)
            }
        }
        
    }
}

struct view3: View {
    
    @Binding var mainNavPath: NavigationPath
    
    var body : some View {
        ZStack {
            Color.green.ignoresSafeArea()
            Text("VIEW 3")
                .foregroundColor(.white)
                .font(.largeTitle)
            
            Button("Back to Root:"){
                mainNavPath.removeLast()
                mainNavPath.removeLast()
            }
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .cornerRadius(8)
            .padding(.top, 300)
        }
    }
}

#Preview {
    TestView()
}

