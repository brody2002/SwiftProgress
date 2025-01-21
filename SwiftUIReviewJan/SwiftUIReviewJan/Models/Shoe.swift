//
//  Shoe.swift
//  SwiftUIReviewJan
//
//  Created by Brody on 1/21/25.
//

import Foundation
import SwiftData

@Model
class Shoe: ObservableObject, Identifiable {
    // Name
    var name: String
    
    // Stats
    var traction: Int
    var cushion: Int
    var style: Int
    
    init(name: String = "Basic Shoe", traction: Int = 7, cushion: Int = 3, style: Int = 7) {
        self.name = name
        self.traction = traction
        self.cushion = cushion
        self.style = style
    }
}
