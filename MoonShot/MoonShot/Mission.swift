//
//  Mission.swift
//  MoonShot
//
//  Created by Brody on 10/15/24.
//

import Foundation



struct Mission: Codable, Identifiable{
    
    struct CrewRole: Codable{
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    var displayName: String {
        "Apollo \(id)"
    }
    
    var image: String {
        "apollo\(id)"
    }
    

    var formattedLaunchDate: String {
        // launchDate was made in a specific format through the Bundle-Decodable file which is then passed here to return a string or date
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
}
