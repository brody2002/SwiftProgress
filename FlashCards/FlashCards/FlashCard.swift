//
//  FlashCard.swift
//  FlashCards
//
//  Created by Brody on 11/15/24.
//

import Foundation
import SwiftUI

struct FlashCard: Codable{
    var prompt: String
    var answer: String
    
    static let example = FlashCard(prompt: "who is the goat?", answer: "LeBron")
}
