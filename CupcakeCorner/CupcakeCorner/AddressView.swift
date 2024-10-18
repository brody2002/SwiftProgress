//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Brody on 10/18/24.
//

import SwiftUI

struct AddressView: View {
    @Bindable var order: Order
    
    var body: some View {
        
        Form{
            Section{
                TextField("Name:", text: $order.name)
                TextField("Street Address:", text: $order.streetAddress)
                TextField("City:", text: $order.city)
                TextField("ZIP:", text: $order.zip)
            }
            Section{
                NavigationLink("Check Out"){
                    CheckoutView(order: order)
                }
                .disabled(!order.isValidAddress)
            }
        }
    }
}

#Preview {
    AddressView(order: Order())
}
