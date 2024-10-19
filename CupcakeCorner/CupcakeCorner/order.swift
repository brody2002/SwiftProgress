    //
    //  order.swift
    //  CupcakeCorner
    //
    //  Created by Brody on 10/18/24.
    //

    import Foundation


    import SwiftUI



    @Observable
    class Order : Codable {
        enum CodingKeys: String, CodingKey {
            case _type = "type"
            case _quantity = "quantity"
            case _specialRequestEnabled = "specialRequestEnabled"
            case _oreos = "oreos"
            case _addSprinkles = "addSprinkles"
            case _name = "name"
            case _city = "city"
            case _streetAddress = "streetAddress"
            case _zip = "zip"
        }
        
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
        
        var isValidAddress: Bool {
            if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
               streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
               city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
               zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                return false
            }
            return true
        }
        
        var cost: Decimal {
            // $2 per cake
            var cost = Decimal(quantity) * 2

            // complicated cakes cost more
            cost += Decimal(type) / 2

            // $1/oreos
            if oreos {
                cost += Decimal(quantity)
            }

            // $0.50/cake for sprinkles
            if addSprinkles {
                cost += Decimal(quantity) / 2
            }

            return cost
        }
        
    }
