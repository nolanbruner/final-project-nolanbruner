//
//  MoodView.swift
//  OCKSample
//
//  Created by Nolan Bruner on 5/10/21.
//  Copyright © 2021 Network Reconnaissance Lab. All rights reserved.
//


import SwiftUI
import CareKitUI
import CareKitStore
import CareKit
//This view allows the user to select an emoji based on their current mood and provides messages to cheer the user up or advice
//This view can be accessed by clicking on the smiley icon in the tab view
struct MoodView: View {
   // @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: MoodValue
    @State var mood = ""
  //  @State var moodTag = 0
    @State private var action: Int? = 0
    //
    
    var body: some View {
    NavigationView {
        VStack {
     //   Form {
       //     Section(header: Text("Input Value")){
            NavigationLink(destination: MoodView(viewModel: MoodValue()), tag: 1, selection: $action) {
                EmptyView()
            }
                    Text("How are you feeling Today?")
         
            Picker(selection: $mood, label: Text("mood"), content: {
                        Text("😞").tag("Sad")
                        Text("😡").tag("Angry")
                        Text("😴").tag("Sleepy")
                        Text("😓").tag("Stressed")
                        Text("😟").tag("Worried")
                        Text("😱").tag("Scared")
                        Text("😭").tag("Crying")
                        Text("😃").tag("Happy")
                        
                      //  😞😡🤒😴
                    })
                    .padding()
                    .cornerRadius(20.0)
                    .shadow(radius: 20.0, x: 40, y: 200)
            
            
                if mood == "Sad" {
                        Text("It's okay to be sad sometimes")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color(.red))
                            .cornerRadius(10.0)
                            
                            
                 //   viewModel. = mood
             //     viewModel.mood.save()
                   // presentationMode.wrppedValue
                       // mood = "Sad"
                    }
                else if mood == "Angry"{
                    Text("Take a deep breath and relax.")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color(.red))
                        .cornerRadius(10.0)
                        
                        
                        
                }
                else if mood == "Sleepy"{
                    Text("Get some rest and start fresh tomorrow")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color(.red))
                        .cornerRadius(10.0)
                        
                }
                else if mood == "Stressed"{
                    Text("Set small goals, and take small victories")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color(.red))
                        .cornerRadius(10.0)
                        
                }
                else if mood == "Worried"{
                    Text("Get some fresh air to take your mind off things")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color(.red))
                        .cornerRadius(10.0)
                        
                }
                else if mood == "Scared"{
                    Text("You have what it takes, even if you’re scared and think you don’t")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color(.red))
                        .cornerRadius(10.0)
                        
                }
                else if mood == "Crying"{
                    Text("Everyone has their low moments but that only means there are more high moments to come.")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color(.red))
                        .cornerRadius(10.0)
                        
                }
                else if mood == "Happy"{
                    Text("Spread that smile to those who need it!")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color(.red))
                        .cornerRadius(10.0)
                        
                }
            }
        
      //      }
    }
    }
}

struct MoodView_Previews: PreviewProvider {
    static var previews: some View {
        MoodView(viewModel: MoodValue())
    }
}

