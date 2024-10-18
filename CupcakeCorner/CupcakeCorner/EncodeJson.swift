//
//  EncodeJson.swift
//  CupcakeCorner
//
//  Created by Brody on 10/18/24.
//

import SwiftUI

@Observable
class User: Codable {
    enum CodingKeys: String, CodingKey {
        case _name = "name"
    }

    var name = "Brody"
}


struct EncodeJson: View {
    @State private var  encodedString = ""
        var body: some View {
            Button("Encode Brody", action: encodeBrody)
            Spacer()
                .frame(height: 50)
            Button("Decode Brody", action: decodeBrody)
        }

        func encodeBrody() {
            let data = try! JSONEncoder().encode(User())
            print("data size: \(data)")
            encodedString = String(decoding: data, as: UTF8.self)
            print("JSON Data: \(encodedString)")
            print("brody has been encoded")
            
        }
    
    func decodeBrody(){
        guard encodedString.count != 0 else {
            print("string empty")
            return
        }
        guard let data = encodedString.data(using: .utf8) else {
                    print("Invalid JSON string")
                    return
                }
                
                do {
                    let user = try JSONDecoder().decode(User.self, from: data)
                    print("Decoded user: \(user.name)") // Prints decoded User's name
                } catch {
                    print("Failed to decode: \(error)")
                }
    }
    
}

#Preview {
    EncodeJson()
}
