//
//  settingsView.swift
//  OCKSample
//
//  Created by Nolan Bruner on 5/8/21.
//  Copyright © 2021 Network Reconnaissance Lab. All rights reserved.
//

import SwiftUI
import UserNotifications

struct settingsView: View {
    @State var notificationPermission = 0
    @State var waterNotification = 0
    @State var notificationInterval = ""
    var body: some View {
        
        VStack{
            Text("Settings")
                .font(.title)
                .padding()
               
            Text("Notification Settings")
                .font(.headline)
                .padding()
            HStack{
            
                Text("Request Permission for Notifications")
                    .padding()
            Picker(selection: $notificationPermission, label: Text("Request Permission for Notifications"), content:{
                Text("No").tag(0)
                Text("Yes").tag(1)
            })
            .pickerStyle(SegmentedPickerStyle())
            .background(Color.white)
            .cornerRadius(20.0)
            .padding()
            }
            
            if notificationPermission == 1{
                Button("Confirm"){
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]){success, error in
                    if success{
                        print("All set!")
                    }

                    else if let error = error {
                        print(error.localizedDescription)
                        }
                    }
                }
                .padding()
                .foregroundColor(.blue)
            }
           
            
            HStack{
            
                Text("Would you like to recieve reminders to drink water?")
                    .padding()
            Picker(selection: $waterNotification, label: Text("Schedule a notification to drink water"), content:{
                Text("No").tag(0)
                Text("Yes").tag(1)
            })
            .pickerStyle(SegmentedPickerStyle())
            .background(Color.white)
            .cornerRadius(20.0)
            .padding()
            }
            if waterNotification == 1{
                HStack{
                Text("How often would you like to recieve notifications?")
                TextField("Seconds", text: $notificationInterval)
                    //.keyboardType(.numberPad)
                    .padding()
                }
                .padding()
                if Double(notificationInterval) != nil {
                Button("Confirm"){
                let content = UNMutableNotificationContent()
                content.title = "Drink Water"
               // content.subtitle = "It is important"
                content.sound = UNNotificationSound.default

                // Converts string entered by user into type Double
                let notificationIntervalInSeconds = Double(notificationInterval)
                    
                    // let notificationIntervalInHours = notificationIntervalInSeconds*3600
                
                //set repeats to true for daily notifications
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: notificationIntervalInSeconds!, repeats: false)
                    
                // choose a random identifier
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                // add our notification request
                UNUserNotificationCenter.current().add(request)
                }
                .padding()
                .foregroundColor(.blue)
                }
               
            }
        }
    }
}

struct settingsView_Previews: PreviewProvider {
    static var previews: some View {
        settingsView()
    }
}
