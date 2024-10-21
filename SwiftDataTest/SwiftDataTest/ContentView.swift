    //
    //  ContentView.swift
    //  SwiftDataTest
    //
    //  Created by Brody on 10/21/24.
    //
    import SwiftData
    import SwiftUI

    @Model
    class PersonClass {
        var id: UUID
        var name: String
        var favAnimal: String
        
        init(){
            self.id = UUID()
            self.name = ["Sarah","Lauren","Syd","Brody"].randomElement()!
            self.favAnimal = ["pigeon","dog","cat"].randomElement()!
        }
    }

    struct ContentView: View {
        
        @Environment(\.modelContext) var mainContext
        @Query var PersonClassList: [PersonClass]
        
        var body: some View {
            VStack {
                Button("Clear All") {
                   print("Clearing all persons")
                   for person in PersonClassList {
                       mainContext.delete(person) // Delete each person from the context
                   }
                   do {
                       try mainContext.save() // Save changes to reflect the deletion
                   } catch {
                       print("Failed to clear context: \(error)")
                   }
               }
               .padding()
               .background(.red)
               .foregroundStyle(Color.white)
               .cornerRadius(20)
                Button("Add Person"){
                    print("Adding person")
                    mainContext.insert(PersonClass())
                    do {
                        print("saving? ")
                        try mainContext.save()
                    } catch {
                        print("didn't save context")
                    }
                }
                .padding()
                .background(.blue)
                .foregroundStyle(Color.white)
                .cornerRadius(20)
                Button("Print list"){
                    print("Print list")
                    print(PersonClassList)
                    print()
                }
                .padding()
                .background(.blue)
                .foregroundStyle(Color.white)
                .cornerRadius(20)
                
                List{
                    ForEach(PersonClassList, id: \.id){ person in
                        Text("\(person.name) - Favorite Animal: \(person.favAnimal)")                    }
                }
            }
            .padding()
        }
    }

    #Preview {
        ContentView()
                .modelContainer(for: PersonClass.self, inMemory: true) // Use in-memory container for preview
    }
