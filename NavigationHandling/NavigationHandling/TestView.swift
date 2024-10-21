import SwiftData
import SwiftUI

@Model
class PersonClass {
    var id: UUID
    var name: String
    var favAnimal: String
    
    init(id: UUID, name: String, favAnimal: String) {
        self.id = id
        self.name = name
        self.favAnimal = favAnimal
    }
}

struct TestView: View {
    @Environment(\.modelContext) var context
    @State private var mainNavPath = NavigationPath()
    @Query var peopleList: [PersonClass] // Query for live updates from SwiftData

    var body: some View {
        NavigationStack(path: $mainNavPath) {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.yellow, Color.orange]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                NavigationLink("Entrance to next view:", value: "TestView1")
                    .navigationDestination(for: String.self) { value in
                        if value == "TestView1" {
                            window(mainNavPath: $mainNavPath)
                        }
                        if value == "view 3" {
                            view3(mainNavPath: $mainNavPath) // Navigate to the third view
                        }
                    }
            }
            .toolbar {
                Button("Add person") {
                    let names = ["Sarah", "Lauren", "Syd", "Brody"]
                    let animals = ["Cat", "Dog", "Pigeon"]
                    let chosenName = names.randomElement()
                    let chosenAnimal = animals.randomElement()

                    let newPerson = PersonClass(id: UUID(), name: chosenName!, favAnimal: chosenAnimal!)
                    
                    print("\(newPerson.name) is being added")
                    // Insert the new person into the SwiftData modelContext
                    context.insert(newPerson)
                    
                    print("Added person to the list")
                    do {
                                            try context.save() // Force save the context
                                            print("Added person to the list and saved")
                                        } catch {
                                            print("Error saving person: \(error)")
                                        }
                }
                
                Button("Print list") {
                                    print("Printing list:")
                                    
                                    // Print the people fetched by the @Query
                                    if peopleList.isEmpty {
                                        print("No people found in list.")
                                    } else {
                                        for person in peopleList {
                                            print("Fetched Person: \(person.name), Favorite Animal: \(person.favAnimal)")
                                        }
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
    
    var body: some View {
        ZStack {
            Color.green.ignoresSafeArea()
            Text("VIEW 3")
                .foregroundColor(.white)
                .font(.largeTitle)
            
            Button("Back to Root:") {
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

