//
//  UsersView.swift
//  UserInterface
//
//  Created by Brody on 10/21/24.
//

import SwiftData
import SwiftUI

struct UsersView: View {
    
    
    @Environment(\.modelContext) var modelContext
    @Query var users: [AddUser]
    
    
    func addSample() {
        let user1 = AddUser(name: "Piper Chapman", city: "New York", joinDate: .now)
        let job1 = Job(name: "Organize sock drawer", priority: 3)
        let job2 = Job(name: "Make plans with Alex", priority: 4)

        modelContext.insert(user1)

        user1.jobs.append(job1)
        user1.jobs.append(job2)
    }
    
    
    
    var body: some View {
        List(users) { user in
            HStack {
                Text(user.name)

                Spacer()

                Text(String(user.jobs.count))
                    .fontWeight(.black)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(.capsule)
            }
        }
        
        
    }
    //filters to see if the user joined after joindate from minimumJoinDate var
    init(minimumJoinDate: Date, sortOrder: [SortDescriptor<AddUser>]) {
        _users = Query(filter: #Predicate<AddUser> { user in
            user.joinDate >= minimumJoinDate
        }, sort: sortOrder)
    }
}

#Preview {
    UsersView(minimumJoinDate: .now, sortOrder: [SortDescriptor(\AddUser.name)])
        .modelContainer(for: AddUser.self)
}
