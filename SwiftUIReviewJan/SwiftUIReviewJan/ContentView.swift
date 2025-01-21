//
//  ContentView.swift
//  SwiftUIReviewJan
//
//  Created by Brody on 1/21/25.
//


import SwiftUI
import SwiftData

struct ContentView: View {
    // Params
    @Binding var loadShoes: Bool
    // -----------------------
    @State var navPath: NavigationPath = NavigationPath()
    
    @State var inputShoeName: String?
    @State var inputShoeTraction: String?
    @State var inputShoeCushion: String?
    @State var inputShoeStyle: String?
    
    @Query(sort: [SortDescriptor(\Shoe.name)]) var shoeData: [Shoe]
    @Environment(\.modelContext) var modelContext
    
    @State private var showAddShoeSheet: Bool = false
    
    var body: some View {
        NavigationStack(path: $navPath) {
            VStack {
                    List{
                        ForEach(shoeData, id: \.name){ shoeInfo in
                            VStack{
                                HStack(alignment: .top){
                                    Spacer()
                                        .frame(maxWidth: 1)
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundStyle(Color.pink)
                                        .frame(width: 160, height: 100)
                                    Spacer()
                                        .frame(width: 20)
                                    VStack(alignment: .leading){
                                        Text("Shoe Name: \(shoeInfo.name)")
                                        Text("Shoe Traction: \(shoeInfo.traction)")
                                        Text("Shoe Cushion: \(shoeInfo.cushion)")
                                        Text("Shoe Style: \(shoeInfo.style)")
                                    }
                                    Spacer()
                                }
                                .onTapGesture {
                                    //Show Details of Show
                                }
                                
                            }
                        }
                        .onDelete(perform: deleteShoe)
                    }
                
                RoundedRectangle(cornerRadius: 10)
                    .frame(
                        width: UIScreen.main.bounds.width * 0.9,
                        height: UIScreen.main.bounds.height * 0.1
                    )
                    .overlay(
                        Text("Add Shoe")
                            .foregroundStyle(.white)
                            .font(.system(size: 30).bold())
                    )
                    .onTapGesture {
                        showAddShoeSheet.toggle()
                    }
            }
            .fontDesign(.rounded)
            .navigationTitle("Basketball Shoes")
            .sheet(isPresented: $showAddShoeSheet) {
                AddShoeView(shoeList: shoeData, showAddShoeSheet: $showAddShoeSheet)
            }
            .onAppear(perform: loadShoesFirstTime)
        }
        
    }
    func deleteShoe(at offsets: IndexSet) {
            for index in offsets {
                let shoeToDelete = shoeData[index]
                modelContext.delete(shoeToDelete)
            }
            do {
                try modelContext.save()
            } catch {
                print("Error deleting shoe: \(error)")
            }
        }
    
    func loadShoesFirstTime() {
        if loadShoes == true{
            modelContext.insert(Shoe(name: "Kobe 8", traction: 8, cushion: 7, style: 9))
            modelContext.insert(Shoe(name: "KD 7", traction: 9, cushion: 9, style: 9))
            modelContext.insert(Shoe(name: "Lebron 16", traction: 3, cushion: 8, style: 4))
            loadShoes = false
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Shoe.self, configurations: config)
    container.mainContext.insert(Shoe(name: "WOW 808 4Ultra", traction: 10, cushion: 8, style: 7))
    container.mainContext.insert(Shoe(name: "Lebron 20", traction: 10, cushion: 10, style: 9))
    container.mainContext.insert(Shoe(name: "Kobe 8", traction: 10, cushion: 6, style: 9))
    
    return ContentView(loadShoes: .constant(true))
        .modelContainer(container)
}
