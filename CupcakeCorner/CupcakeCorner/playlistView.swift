//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Brody on 10/18/24.
//

import SwiftUI

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

//Handle Images that don't load from the internet
struct AlbumImage: View{
    var body: some View{
        AsyncImage(url: URL(string: "https://hws.dev/img/bad.png")) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .frame(width: 50, height: 50)
                    .scaledToFit()
            } else if phase.error != nil {
                Text("There was an error loading the image.")
            } else {
                ProgressView()
            }
        }
        .frame(width: 200, height: 200)
    }
}

struct playlistView: View {
    @State private var results = [Result]()
    var body: some View {
        List(results, id: \.trackId) { result in
            
            VStack(alignment: .leading) {
                Spacer()
                Text(result.trackName)
                    .font(.headline)
                Text(result.collectionName)
                Spacer()
            }
            .listRowBackground(Color.orange)
            .cornerRadius(30)
            .padding()
            
        }
        .task {
            // await KeyWord meaning:
            /*“this work will take some time, so please wait for it to complete while the rest of the app carries on running as usual.”*/
            await loadData()
        }
    }
    
    func loadData() async {
        guard let url = URL(string: "https://itunes.apple.com/search?term=kendrick+lamar&entity=song") else {
            print("Invalid URL")
            return
        }
        
        do {
            //Load data
            // return type -> (data, metadata)
            let (data, _) = try await URLSession.shared.data(from: url)
            
            
            //decode data
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) { // Use 'Response' here
                results = decodedResponse.results
            }
        } catch {
            print("invalid data")
        }
    }
}

#Preview {
    playlistView()
}


