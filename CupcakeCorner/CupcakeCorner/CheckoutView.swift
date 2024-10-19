//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Brody on 10/18/24.
//

import SwiftUI

struct CheckoutView: View {
    var order: Order
    
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    @State private var showingInternetNoti = false
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else{
            print("failed to encode")
            return
        }
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        // for testing if no connection
//        request.httpMethod = ""

        
        
        // Check if httpMethod is set properly
        guard let httpMethod = request.httpMethod, !httpMethod.isEmpty else {
            print("No HTTP method set")
            showingInternetNoti = true
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            // handle the result
            
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) \(decodedOrder.quantity == 1 ? "cupcake" : "cupcakes") is on its way!"
            showingConfirmation = true
            
            
        } catch {
            print("Checkout failed: \(error.localizedDescription)")
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place Order", action: {
                    Task{
                        await placeOrder()
                    }
                })
                .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Thank you!", isPresented: $showingConfirmation) {
            Button("OK") { }
        } message: {
            Text(confirmationMessage)
        }
        .alert("No Internet", isPresented: $showingInternetNoti){
            Button("Sad"){}
        } message: {
            Text("NO WIFI :(")
        }
    }
}



#Preview {
    CheckoutView(order: Order())
}
