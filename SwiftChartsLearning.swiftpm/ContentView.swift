import SwiftUI
import Charts

struct ContentView: View {
    @State var navPath = NavigationPath()
    let doggoArray: [Dog] = [
        Dog(breed: "Yorkie", numberOfSnacks: 33),
        Dog(breed: "Norwhich Terrier", numberOfSnacks: 39),
        Dog(breed: "German Shepard", numberOfSnacks:   103),
        Dog(breed: "Berner", numberOfSnacks: 45),
        Dog(breed: "Golden Retreiver", numberOfSnacks: 57)
    ]
    
    var body: some View {
        NavigationStack(path: $navPath){
            
            NavigationLink(value: "yorkie"){
                Text("hello doggo yorkie button")
            }
            
            VStack {
                Text("Dog's and Their # of Snacks")
                    .font(.title.bold())
                    .multilineTextAlignment(.center)
                Text("Swift Charts Demo")
                    .font(.footnote.bold())
                    .foregroundStyle(.gray)
                
                Chart {
                    RuleMark(y: .value("Goal", 66))
                        .lineStyle(StrokeStyle(lineWidth: 3, dash: [10]))
                        .cornerRadius(10)
                        .foregroundStyle(.blue)
                    ForEach(doggoArray){ dog in
                        BarMark(
                            x: .value("Breed", dog.breed),
                            y: .value("Number of Snacks", dog.numberOfSnacks)
                        )
                        .cornerRadius(10)
                        .foregroundStyle(.pink.gradient)
                        .annotation {
                            Text("\(dog.numberOfSnacks)")
                                .bold()
                        }
                        
                    }
                }
            }
            .frame(height: 400)
            .chartPlotStyle { plotContent in
                plotContent
                    .background(.gray.gradient.opacity(0.3))
            }
            .chartXAxis {
                AxisMarks(values: doggoArray.map { $0.breed }) { value in
                    AxisTick()
                    AxisGridLine(stroke: StrokeStyle(lineWidth: 3, dash: [10]))
                        .foregroundStyle(.yellow)
                    
                    AxisValueLabel(centered: true){
                        if let breed = value.as(String.self) {
                            Text(breed.prefix(3))
                                .font(.headline) // Set your desired font here
                                .foregroundColor(.black) // Optional: Set a custom color
                                .font(.system(size: 40))
                            
                        }
                    }
                }
            }
            .chartYAxis {
                AxisMarks(values: doggoArray.map { $0.numberOfSnacks}) { value in
                    AxisTick()
                    AxisGridLine(stroke: StrokeStyle(lineWidth: 2))
                        .foregroundStyle(.pink)
                    AxisValueLabel()
                }
            }
            .navigationDestination(for: String.self) { dest in
                switch dest {
                case "yorkie":
                    Text("DOGGO YORKIE VIEW")
                default:
                    Text("sad no doggo")
                }
                 
            }
        }
        
    }
}


struct Dog: Identifiable {
    
    var id = UUID()
    var breed: String
    var numberOfSnacks: Int
    
    init(id: UUID = UUID(), breed: String, numberOfSnacks: Int) {
        self.id = id
        self.breed = breed
        self.numberOfSnacks = numberOfSnacks
    }
    
}


