//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Brody on 10/18/24.
//

import SwiftUI

struct ContentView: View {
    @State private var order = Order()
    
    
    func incrementStep() {
        order.quantity += 1
    }


    func decrementStep() {
        if order.quantity > 1{
            order.quantity -= 1
        }
        
        
    }
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    Picker("Select Type of IceCream: ", selection: $order.type){
                        ForEach(Order.types.indices, id: \.self){
                            Text(Order.types[$0])
                        }
                    }
                    Stepper("Number of Scoops: \(order.quantity)", onIncrement: {
                                            incrementStep()
                                        }, onDecrement: {
                                            decrementStep()
                                        })
                        
                }
                Section {
                    Toggle("Any special requests?", isOn: $order.specialRequestEnabled)

                    if order.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.oreos)

                        Toggle("Add extra sprinkles", isOn: $order.addSprinkles)
                    }
                }
                Section{
                    NavigationLink("Delivery Details: "){
                        AddressView(order: order)
                    }
                }
            }.navigationTitle("ICECREAM STORE")
        }
    }
}

#Preview {
    ContentView()
}
