//
//  ContentView.swift
//  WeSplit
//
//  Created by Brody on 10/8/24.
//

import SwiftUI

struct ContentView: View {
    @State private var numPeople: Int = 0
    @State private var checkAmount: Double = 0.0
    @State private var tipPercentage = 20
    @FocusState private var keyboardFocus: Bool
    @State private var totalAmount : Double = 0.0
    
    
    let tipPercentages = [5, 10 ,15, 20 ,25, 0]
    
    var totalPerPerson: Double {
        //Calc total per person
        let peopleCount = Double(numPeople + 2)
        let tipPercentage = Double(tipPercentage)
        let tipAmount = checkAmount /  100 * tipPercentage
        let totalAmount = checkAmount + tipAmount
        // Ret Amount per person
        return (totalAmount / peopleCount)
    }
    
    var totalCost: Double {
        let total: Double = checkAmount + (checkAmount /  100 * Double(tipPercentage))
        return total
    }
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($keyboardFocus)
                    Picker("Number of People: ", selection: $numPeople){
                        ForEach(2..<100){ Num in
                            Text("\(Num) people")
                        }
                    }/*.pickerStyle(.navigationLink) */ //Adds Menu in order to choose num of people
                }
                Section("Tip Amount:"){
                   
                    Picker("Tip Percentage: ", selection: $tipPercentage){
                        ForEach(tipPercentages, id: \.self){
                            Text($0,format: .percent)
                        }
                    }.pickerStyle(.segmented)
                }
                Section("Total amount: "){
                    Text(totalCost, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                Section("Amount per Person: "){
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("Split Tab")
            .toolbar {
                if keyboardFocus {
                    Button("Done"){
                        keyboardFocus = false
                    }
                }
            }
                    
        }
        
            
        
        
        
        
    }
}

#Preview {
    ContentView()
}
