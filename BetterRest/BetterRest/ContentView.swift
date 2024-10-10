//
//  ContentView.swift
//  BetterRest
//
//  Created by Brody on 10/10/24.
//

import SwiftUI
import CoreML

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var coffeeAmount = 1
    @State private var sleepAmount = 8.0
    
    @State private var alertMessage = ""
    @State private var alertTitle = ""
    @State private var showingAlert = false
    
    static var defaultWakeTime : Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    
    var body: some View {
        NavigationStack{
            Form    {
                
                VStack(alignment: .leading, spacing: 20){
                    Text("When do you want to wake up?")
                        .font(.headline)
                    DatePicker("Please enter a time: ", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                VStack(alignment: .leading,spacing: 20) {
                    Text("Desired Amount of Sleep:")
                        .font(.headline)
                    
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount,in: 4...12, step: 0.25)
                }
                VStack(alignment: .leading,spacing: 20) {
                    Text("Daily Coffee Intake:")
                        .font(.headline)
                    
                    Stepper("^[\(coffeeAmount) cup](inflect: true)", value: $coffeeAmount, in: 1...20)
                    
                    
                }
                
                Button("Calculate", action: calcBedtime)
                    .padding()
                    .background(Color.indigo.gradient)
                    .cornerRadius(20)
                    .foregroundStyle(Color.black)
                
                
                
            
            }
            .navigationTitle("BetterRest")
            
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("Ok") {
                    // Action for the button (optional)
                }
            } message: {
                Text(alertMessage)
            }
        }
    }
    func calcBedtime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator2(configuration: config)
            
            let componenets = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (componenets.hour ?? 0 ) * 60 * 60
            let minute = (componenets.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            alertTitle = "Your ideal bedtime is..."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
        }
        catch{
            alertTitle = "Error"
            alertMessage = "Sorry there was trouble calculating your bedtime"
            
        }
        showingAlert = true
    }
}

#Preview {
    ContentView()
}
