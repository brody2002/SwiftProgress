//
//  order.swift
//  CupcakeCorner
//
//  Created by Brody on 10/18/24.
//

import Foundation


import SwiftUI



@Observable
class Order{
    
    static let types = ["Vanilla", "Chocolate","RainBow","Strawberry"]
    
    var type = 0
    var quantity = 1
    
    var specialRequestEnabled = false {
        didSet{
            if specialRequestEnabled == false {
                oreos = false
                addSprinkles = false 
            }
        }
    }
    var oreos = false
    var addSprinkles = false
    
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var isValidAddress : Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        return true
    }
    
}
