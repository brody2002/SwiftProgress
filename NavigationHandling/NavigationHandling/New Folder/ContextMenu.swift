//
//  ContextMenu.swift
//  NavigationHandling
//
//  Created by Brody on 11/15/24.
//

import Foundation
import SwiftUI

struct contextMenu: View{
    @State private var backgroundColor: Color = Color.green
    var body: some View{
        ZStack{
            backgroundColor.ignoresSafeArea()
            VStack{
                Text("Context Menu Button")
                    .contextMenu {
                        Button("Blue") {
                            backgroundColor = Color.blue
                        }
                        Button("Yellow") {
                            backgroundColor = Color.yellow
                        }
                        Button("Purple") {
                            backgroundColor = Color.purple
                        }
                    }
                    .padding()
                    .foregroundStyle(Color.white)
                    .background(Color.gray.opacity(0.3))
                    .frame(width: 150, height: 80)
                    .cornerRadius(30)
                
                Button("Request Permission") {
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                        if success {
                            print("All set!")
                        } else if let error {
                            print(error.localizedDescription)
                        }
                    }
                }

                Button("Schedule Notification") {
                    let content = UNMutableNotificationContent()
                    content.title = "Feed the dog"
                    content.subtitle = "It looks hungry"
                    content.sound = UNNotificationSound.default

                    // show this notification five seconds from now
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

                    // choose a random identifier
                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                    // add our notification request
                    UNUserNotificationCenter.current().add(request)
                }
            }
            
            
                
                

                
        }
        
    }
}


#Preview{
    contextMenu()
}
