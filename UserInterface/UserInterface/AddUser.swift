//
//  AddUser.swift
//  UserInterface
//
//  Created by Brody on 10/21/24.
//

import SwiftData
import SwiftUI

@Model
class AddUser {
    var name: String
    var city: String
    var joinDate: Date
    @Relationship(deleteRule: .cascade) var jobs = [Job]()

    init(name: String, city: String, joinDate: Date) {
        self.name = name
        self.city = city
        self.joinDate = joinDate
    }
}

@Model
class Job {
    var name: String
    var priority: Int
    var owner: AddUser?

    init(name: String, priority: Int, owner: AddUser? = nil) {
        self.name = name
        self.priority = priority
        self.owner = owner
    }
}


struct EditUserView: View {
    @Bindable var user: AddUser

    var body: some View {
        Form {
            TextField("Name", text: $user.name)
            TextField("City", text: $user.city)
            DatePicker("Join Date", selection: $user.joinDate)
        }
        .navigationTitle("Edit User")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: AddUser.self, configurations: config)
        let user = AddUser(name: "Drake", city: "Toronto", joinDate: .now)
        return EditUserView(user: user)
            .modelContainer(container)
    } catch {
        return Text("Failed to create container: \(error.localizedDescription)")
    }
}
