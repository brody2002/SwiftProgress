//
//  ContentView.swift
//  BucketList
//
//  Created by Brody on 10/23/24.
//

import SwiftUI

struct PersonStruct: Decodable, Encodable, Comparable, Identifiable{
    var id = UUID()
    var firstName: String
    var lastName: String
    
    
    
    //Sorting Custom Objects
    static func <(lhs:PersonStruct, rhs:PersonStruct) -> Bool {
        if lhs.firstName == rhs.firstName {
            if lhs.lastName == rhs.lastName{
                return lhs.id < rhs.id
            } else { return lhs.lastName < rhs.lastName }
        } else {
            return lhs.firstName < rhs.firstName
        }
    }
}

struct ContentView: View {
    private var peoples = [
        PersonStruct(firstName: "Brody", lastName: "Roberts"),
        PersonStruct(firstName: "Sarah", lastName: "Graessley"),
        PersonStruct(firstName: "Brody", lastName: "Woberts"),
        PersonStruct(firstName: "Brody", lastName: "Woberts")
    ].sorted()
    
    @State private var showList = false

    var body: some View {
        VStack {
            Button("Press to See List") {
                showList = true
            }

            if showList {
                ForEach(peoples) { people in
                    Text("\(people.firstName), \(people.lastName)")
                }
            }

            Spacer().frame(height: 100)

            Button("Save Data") {
                FileManager.default.save(peoples, to: "people.json")
            }

            Button("Load Data") {
                if let loadedPeople: [PersonStruct] = FileManager.default.load([PersonStruct].self, from: "people.json") {
                    print("Loaded: \(loadedPeople)")
                }
            }
        }
        .padding()
    }
}

extension FileManager {
    
    // Save Codable data to the documents directory
    func save<T: Codable>(_ object: T, to filename: String) {
        let url = URL.documentsDirectory.appendingPathComponent(filename)
        let encoder = JSONEncoder()

        do {
            let data = try encoder.encode(object)
            try data.write(to: url, options: [.atomic, .completeFileProtection])
            print("Successfully saved to \(url)")
        } catch {
            print("Failed to save \(filename): \(error.localizedDescription)")
        }
    }
    
    // Load Codable data from the documents directory
    func load<T: Codable>(_ type: T.Type, from filename: String) -> T? {
        let url = URL.documentsDirectory.appendingPathComponent(filename)
        let decoder = JSONDecoder()
        
        do {
            let data = try Data(contentsOf: url)
            return try decoder.decode(T.self, from: data)
        } catch {
            print("Failed to load \(filename): \(error.localizedDescription)")
            return nil
        }
    }
}



#Preview {
    ContentView()
}
