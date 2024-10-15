//
//  ListDelete.swift
//  AnimationsLearning
//
//  Created by Brody on 10/14/24.
//

import SwiftUI

struct example: Identifiable, Codable {
    var id =  UUID()
    let name: String
    let number: Int
}

@Observable
class exampleList{
    var items =  [example](){
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([example].self, from: savedItems) {
                items = decodedItems
                return
            }
        }

        items = []
    }
}
    


struct ListDelete: View {
    @State private var exList = exampleList()
    
    var body: some View {
        NavigationStack{
            List {
                ForEach(exList.items, id: \.name){ item in
                    Text("Item")
                }.onDelete(perform: removeItems)
            }.navigationTitle("TestView")
                .toolbar {
                    Button("Add Example", systemImage: "plus") {
                        let example = example(name: "Test", number: 2)
                        exList.items.append(example)
                    }
                }
            
        }
    }
    func removeItems(at offsets: IndexSet) {
        exList.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ListDelete()
}
