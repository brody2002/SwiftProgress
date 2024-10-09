//
//  ContentView.swift
//  Day19
//
//  Created by Brody on 10/8/24.
//

import SwiftUI

struct ContentView: View {
    @State private var inputValue: Double = 0.0
    @State private var currentUnit: String = "Kelvin"
    @State private var outputUnit: String = "Kelvin"
    
    private var converter: Double {
        guard currentUnit != outputUnit else { return inputValue}
        
        if currentUnit == "Kelvin"{
            switch outputUnit {
            case "Celcius":
                return inputValue - 273.15
            case "Farenheit":
                return (inputValue - 273.15) * 9/5 + 32
            default:
                return inputValue
            }
        }
        if currentUnit == "Celcius"{
            switch outputUnit {
            case "Kelvin":
                return inputValue + 273.15
            case "Farenheit":
                return (inputValue * 9/5) + 32
            default:
                return inputValue
            }
        }
        if currentUnit == "Farenheit"{
            switch outputUnit {
            case "Kelvin":
                return (inputValue - 32) * 5/9 + 273.15
            case "Celcius":
                return (inputValue - 32) * 5/9
            default:
                return inputValue
            }
        }
        
        return 0.0
    }
    
    let listUnits = ["Kelvin", "Farenheit", "Celcius"]
    
    var body: some View {
        NavigationStack{
            
            Form{
                
                Section("Input: "){
                    //Question: How can I look at the types of formats
                    //Eg: format: .number where is this in the docs?
                    
                    Picker("Input Unit: ", selection: $currentUnit){
                        ForEach(listUnits, id: \.self){
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                    TextField("Input", value: $inputValue, format: .number)
                        .keyboardType(.decimalPad)
                    
                    
                }
                Section("Output: "){
                    Picker("Input Unit: ", selection: $outputUnit){
                        ForEach(listUnits, id: \.self){
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                    Text(converter, format: .number)
                }
                
            }.navigationTitle("Degree Calc")
        }
        
    }
}

#Preview {
    ContentView()
}
