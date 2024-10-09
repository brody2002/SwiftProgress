//
//  FormView.swift
//  WeSplit
//
//  Created by Brody on 10/8/24.
//

import SwiftUI

struct FormView: View {
    let students = ["Brody", "Sarah", "Kevin"]
    @State var selectedStudent: String = "Brody"
    var body: some View {
        NavigationStack{
            Form{
                Picker("Select Your Student:", selection: $selectedStudent){
                    ForEach(students, id: \.self){
                        Text($0)
                    }
                }
            }
        }
        
        
        
        
    }
}

#Preview {
    FormView()
}
