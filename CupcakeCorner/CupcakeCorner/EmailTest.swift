//
//  EmailTest.swift
//  CupcakeCorner
//
//  Created by Brody on 10/18/24.
//

import SwiftUI




struct EmailTest: View {
    @State private var user: String = ""
    @State private var email: String = ""
    
    var conditoinalBool: Bool {
        user.count < 5 || email.count <  5
        
    }
    
    var body: some View {
        
        Form {
            Section {
                TextField("Enter Username: ", text: $user)
                TextField("Enter Email: ", text: $email)
            }
            Section {
                Button("Create Account: "){
                    print("Creating Account")
                }
            }
            .disabled(conditoinalBool)
        }
    }
}

#Preview {
    EmailTest()
}
