//
//  ContentView.swift
//  BookLibrary
//
//  Created by Brody on 10/21/24.
//


import SwiftData
import SwiftUI

@Model
class Book {
    
    var title: String
    var author: String
    var genre: String
    var review: String
    var rating: Int
    
    init(title: String, author: String, genre: String, review: String, rating: Int){
        self.title = title
        self.author = author
        self.genre = genre
        self.review = review
        self.rating = rating
    }
}

struct ContentView: View {
    @Environment(\.modelContext) var mainContext
    @Query var BookStore: [Book]
    
    
    @State var inputTitle: String = ""
    @State var inputAuthor: String = ""
    @State var inputGenre: String = "Fantasy"
    @State var inputReview: String = ""
    @State var inputRating: Int = 3
    
    private var availableGenres: [String] = ["Mystery", "Fantasy", "Romance", "Thriller", "Historical Fiction", "Biography", "Adventure"]
    
    @State var mainPath: NavigationPath = NavigationPath()
    
    var canSubmit: Bool {
        
        if inputTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || inputAuthor.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || inputGenre.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || inputReview.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
            return false
        }
        return true
    }
    
    var body: some View {
        
        NavigationStack(path: $mainPath){
            Form {
                Section{
                    TextField("Title of Book", text: $inputTitle)
                    TextField("Author of Book", text: $inputAuthor)
                }
                Section("Genre"){
                    Picker("Genre of Book", selection: $inputGenre){
                        ForEach(availableGenres, id: \.self){ genre in
                            Text(genre)
                        }
                    }
                }
                Section("Rating"){
                    
                    ReviewView(rating: $inputRating)
                        .buttonStyle(.plain)
                    
                    
                    TextField("Book Review", text: $inputReview, axis: .vertical)
            
                }
                Section{
                    Button("Add Book"){
                        mainContext.insert(Book(title: inputTitle, author: inputAuthor, genre: inputGenre, review: inputReview, rating: inputRating))
                        do {
                            try mainContext.save()
                        } catch {
                            print("the context couldn't save the added book")
                        }
                    }.disabled(!canSubmit)
                }
                Section{
                    NavigationLink {
                        SecondView(BookStore: BookStore) // The destination view
                    } label: {
                        Text("Catalog") // The label for the link
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white) // Use `foregroundColor` to style text color
                            .cornerRadius(20)
                    }
                    
                }
                Section{
                    Button("test button"){
                        print("BookStore: \(BookStore)")
                    }
                }
                
            
                
            }.navigationTitle("Add to Library")
        }
            
    }
        
}



struct SecondView: View{
    @Environment(\.modelContext) var mainContext
    @State var BookStore: [Book]
    var body : some View {
        
        Button("print list"){
            print(BookStore)
        }
        
        List{
            ForEach(BookStore, id: \.title){ book in
                Text("Title: \(book.title)\nAuthor: \(book.author)\nGenre: \(book.genre)\nRating: \(book.rating, specifier: "%.1f")")
                    
                    
            }.onDelete(perform: deleteBooks)
        }.toolbar{
            ToolbarItem(placement: .topBarTrailing){
                EditButton()
            }
        }
        
    }
    func deleteBooks(at offsets: IndexSet){
        
        for offset in offsets{
            let book = BookStore[offset]
            mainContext.delete(book)
            
        }
    }
    
}

#Preview {
    ContentView()
}
