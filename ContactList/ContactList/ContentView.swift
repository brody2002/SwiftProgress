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
    @Environment(\.modelContext) var modelContext
    @Query var ContactList : [Contact] = [Contact]()
    @State var mainPath: NavigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $mainPath){
            
            
            Form{
                ForEach(ContactList, id: \.id){ contact in
                    
                        NavigationLink(destination: {
                            EditContact(contact: contact)
                        }, label: {Text("\(contact.firstName) \(contact.lastName)")})
                        
                    
                }.onDelete(perform: deleteContact)
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
        }
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
    ContentView()
}
