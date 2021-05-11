//
//  MoodView.swift
//  OCKSample
//
//  Created by Alayna Borowick on 5/10/21.
//  Copyright © 2021 Network Reconnaissance Lab. All rights reserved.
//


import SwiftUI
import CareKitUI
import CareKitStore
import CareKit

struct MoodView: View {
//    @Environment(\.presentationMode) var presentationMode
 //   @ObservedObject var viewModel: MoodValue
    @State var mood = ""
  //  @State var moodTag = 0
    @State private var action: Int? = 0
    ///   - title: The title text to display in the item.
    ///   - detail: The detail text to display in the item. The text is tinted by default.
    ///   - index: The index to insert the item in the list of logged items.
    ///   - animated: Animate the insertion of the logged item.
    
    var body: some View {
    NavigationView {
        VStack {
            NavigationLink(destination: MoodView(), tag: 1, selection: $action) {
                EmptyView()
            }
         
                    Text("How are you feeling Today?")
                    Picker(selection: $mood, label: Text("mood"), content: {
                        Text("Sad").tag("Sad")
                        Text("Neutral").tag("Neutral")
                        Text("Happy").tag("Happy")
                    })
                    .padding()
                    .cornerRadius(20.0)
                    .shadow(radius: 10.0, x: 20, y: 10)
                
                if mood == "Sad" {
                        Text("It's okay to be sad sometimes")
                //    viewModel.save()
                  //  presentationMode.wrppedValue
                       // mood = "Sad"
                    }
                else if mood == "Neutral"{
                    Text("Make up your mind")
                }
                else if mood == "Happy"{
                    Text("Congrats go share the joy!")
                }
            
}
    }
    }
}

struct MoodView_Previews: PreviewProvider {
    static var previews: some View {
       MoodView()
    }
}

