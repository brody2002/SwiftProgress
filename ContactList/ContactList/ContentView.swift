//
//  ContentView.swift
//  ContactList
//
//  Created by Brody on 10/21/24.
//

import SwiftData
import SwiftUI

@Model
class Contact {
    var id: UUID
    var firstName: String
    var lastName: String
    var phoneNumber: String
    var email: String
    var city: String
    
    init(firstName: String, lastName: String, phoneNumber: String, email: String, city: String){
        self.id = UUID()
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.email = email
        self.city = city
    }
    
}

// main View
struct ContentView: View {
    @State var inputSearch: String = ""
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Contact.firstName) var ContactList : [Contact] = [Contact]()
    @State var mainPath: NavigationPath = NavigationPath()
    
    
    var filteredContacts: [Contact] {
           if inputSearch.isEmpty {
               return ContactList
           } else {
               return ContactList.filter { contact in
                   contact.firstName.localizedStandardContains(inputSearch) ||
                   contact.lastName.localizedStandardContains(inputSearch)
               }
           }
       }
    
    
    
        //@Query(filter: #Predicate<User> { user in
    //        user.name.localizedStandardContains("R") &&
    //        user.city == "London"
    //    }, sort: \User.name) var users: [User]
    
    var body: some View {
        NavigationStack(path: $mainPath){
            
            
            Form{
                
                Section("Find Contact"){
                    TextField("Search 🔎", text: $inputSearch)
                }
                    .frame(height: 30)
                
                ForEach(filteredContacts, id: \.id) { contact in
                                    NavigationLink(destination: {
                                        EditContact(contact: contact)
                                    }, label: {
                                        Text("\(contact.firstName) \(contact.lastName)")
                                    })
                                }
                                .onDelete(perform: deleteContact)
            }
            .navigationTitle("Contacts")
            .toolbar{
                ToolbarItem(id: "AddContact", content: {
                    NavigationLink("add" ,value: "AddContact")
                        .navigationDestination(for: String.self){ name in
                            if name == "AddContact"{
                                AddContact(ContactList: ContactList)
                            }
                            
                        }
                })
            }
                
                
                
        }
    }
    
    func deleteContact(at offsets: IndexSet){
        for offset in offsets {
            let contact = ContactList[offset]
            modelContext.delete(contact)
        }
    }
}

struct EditContact: View{
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @Bindable var contact: Contact
    
    
    
    var isFilledOut: Bool {
        if contact.firstName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || contact.lastName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || contact.phoneNumber.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || contact.city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
            return false
        }
        return true
    }
    
    var body: some View{
        Form{
            Section{
                TextField("First", text: $contact.firstName)
                TextField("Last", text: $contact.lastName)
            }
            Section{
                TextField("Number", text: $contact.phoneNumber)
                TextField("Email", text: $contact.email)
            }
            Section{
                TextField("City", text: $contact.city)
            }
        }.navigationTitle("Edit Contact")
    }
}


struct AddContact : View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    var ContactList : [Contact]
    
    var isFilledOut: Bool {
        if inputFirstName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || inputLastName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || inputPhoneNumber.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || inputCity.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
            return false
        }
        return true
    }
    
    @State var inputFirstName = ""
    @State var inputLastName = ""
    @State var inputPhoneNumber = ""
    @State var inputEmail = ""
    @State var inputCity = ""
    
    
    
    var body: some View{
        Form{
            Section{
                TextField("First", text: $inputFirstName)
                TextField("Last", text: $inputLastName)
            }
            Section{
                TextField("Number", text: $inputPhoneNumber)
                TextField("Email", text: $inputEmail)
            }
            Section{
                TextField("City", text: $inputCity)
            }
        }.toolbar{
            ToolbarItem(placement: .topBarTrailing){
                Button("Save"){
                    modelContext.insert(Contact(firstName: inputFirstName, lastName: inputLastName,  phoneNumber: inputPhoneNumber, email: inputEmail, city: inputCity))
                    dismiss()
                }.disabled(!isFilledOut)
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true) // Correctly initialize the model configuration
        let container = try ModelContainer(for: Contact.self, configurations: config)
        
        return ContentView()
            .modelContainer(container) // Attach the model container
    } catch {
        return Text("Failed to create container: \(error.localizedDescription)")
    }
}
