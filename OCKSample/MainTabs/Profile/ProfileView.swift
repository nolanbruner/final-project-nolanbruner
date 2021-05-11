//
//  ProfileView.swift
//  OCKSample
//
//  Created by Corey Baker on 11/24/20.
//  Copyright © 2020 Network Reconnaissance Lab. All rights reserved.
//

import SwiftUI
import CareKitUI
import CareKitStore
import CareKit

struct ProfileView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var profileViewModel = Profile()
    @State private var isLoggedOut = false
    @State var firstName = ""
    @State var lastName = ""
    @State var note = ""
    @State var allergies = ""
    @State var sex = OCKBiologicalSex.female
    @State private var sexOtherField = ""
    
    @State var email = ""
    @State var phone = ""
    @State var street = ""
    @State var city = ""
    @State var state = ""
    @State var zipcode = ""
    @State var country = ""
    @State var birthday = Calendar.current.date(byAdding: .year, value: -20, to: Date())!
    @State private var action: Int? = 0
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: ProfileView(), tag: 1, selection: $action) {
                    EmptyView()
                }
            
        Form {
            Section(header: Text("About")){
 
       // VStack {
     //       VStack(alignment: .leading) {
                TextField("First Name", text: $firstName)
                    .padding()
                    .cornerRadius(20.0)
                    .shadow(radius: 10.0, x: 20, y: 10)
            
                TextField("Last Name", text: $lastName)
                    .padding()
                    .cornerRadius(20.0)
                    .shadow(radius: 10.0, x: 20, y: 10)
                TextField("Note", text: $note )
                    .padding()
                    .cornerRadius(20.0)
                    .shadow(radius: 10.0, x: 20, y: 10)
                DatePicker("Birthday", selection: $birthday, displayedComponents: [DatePickerComponents.date])
                    .padding()
                    .cornerRadius(20.0)
                    .shadow(radius: 10.0, x: 20, y: 10)
            
                /*TextField("Sex", text: $sex)
                    .padding()
                    .cornerRadius(20.0)
                    .shadow(radius: 10.0, x: 20, y: 10)*/
            Picker(selection: $sex, label: Text("Sex"), content: {
                Text(OCKBiologicalSex.female.rawValue).tag(OCKBiologicalSex.female)
                Text(OCKBiologicalSex.male.rawValue).tag(OCKBiologicalSex.male)
                TextField("Other", text: $sexOtherField).tag(OCKBiologicalSex.other(sexOtherField))
                })
                .padding()
                .cornerRadius(20.0)
                .shadow(radius: 10.0, x: 20, y: 10)
            TextField("Allergies", text: $allergies)
                .padding()
                .cornerRadius(20.0)
                .shadow(radius: 10.0, x: 20, y: 10)
                }
            
           Section(header: Text("Contact")){
            TextField("Email", text: $email)
                .padding()
                .cornerRadius(20.0)
                .shadow(radius: 10.0, x: 20, y: 10)
            TextField("Phone Number", text: $phone)
                .padding()
                .cornerRadius(20.0)
                .shadow(radius: 10.0, x: 20, y: 10)
            TextField("Street", text: $street)
                .padding()
                .cornerRadius(20.0)
                .shadow(radius: 10.0, x: 20, y: 10)
            TextField("city", text: $city)
                .padding()
                .cornerRadius(20.0)
                .shadow(radius: 10.0, x: 20, y: 10)
            TextField("State", text: $state)
                .padding()
                .cornerRadius(20.0)
                .shadow(radius: 10.0, x: 20, y: 10)
            TextField("Zip Code", text: $zipcode)
                .padding()
                .cornerRadius(20.0)
                .shadow(radius: 10.0, x: 20, y: 10)
            TextField("country", text: $country)
                .padding()
                .cornerRadius(20.0)
                .shadow(radius: 10.0, x: 20, y: 10)
            
        }
            // This button calls saveProfile which contains all of the strings entered by the user.
            Button(action: {
                profileViewModel.saveProfile(firstName, last: lastName, birth: birthday, note: note, allergies: allergies, sex: sex, email: email, phone: phone, street: street, city: city, state: state, zipcode: zipcode, country: country)
                
            }, label: {
                Text("Save Profile")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 300, height: 50)
            })
            .background(Color(.green))
            .cornerRadius(15)
            
            if #available(iOS 14.0, *) {
                Button(action: {
                    do {
                        try profileViewModel.logout()
                        isLoggedOut = true
                        presentationMode.wrappedValue.dismiss()
                    } catch {
                        print("Error logging out: \(error)")
                    }
                    
                }, label: {
                    
                    Text("Log Out")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 300, height: 50)
                })
                .background(Color(.red))
                .cornerRadius(15)
                .fullScreenCover(isPresented: $isLoggedOut, content: {
                    LoginView()
                })
            } else {
                // Fallback on earlier versions
                Button(action: {
                    do {
                        try profileViewModel.logout()
                        isLoggedOut = true
                        presentationMode.wrappedValue.dismiss()
                    } catch {
                        print("Error logging out: \(error)")
                    }
                    
                }, label: {
                    
                    Text("Log Out")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 300, height: 50)
                })
                .background(Color(.red))
                .cornerRadius(15)
                .sheet(isPresented: $isLoggedOut, content: {
                    LoginView()
                })
            }
            // fill text boxes if they are in the Database
            // .onRecieve allows the app to populate the TextFields if the values are already stored in the database
        }.onReceive(profileViewModel.$patient, perform: { patient in
            if let currentFirstName = patient?.name.givenName {
                firstName = currentFirstName
            }
            
            if let currentLastName = patient?.name.familyName {
                lastName = currentLastName
            }
            
            if let currentBirthday = patient?.birthday {
                birthday = currentBirthday
            }
            if let currentAllergies = patient?.allergies?.last{
                allergies = currentAllergies
            }
            if let currentNote = patient?.notes?.first?.content{
                note = currentNote
            }
            
            if let currentSex = patient?.sex{
                sex = currentSex
                
            }
        }).onReceive(profileViewModel.$contact, perform: { contact in
            if let currentEmail = contact?.emailAddresses?.first {
                email = currentEmail.value
            }
            
            if let currentPhone = contact?.phoneNumbers?.first {
                phone = currentPhone.value
            }
            if let currentStreet = contact?.address?.street{
                street = currentStreet
            }
            if let currentCity = contact?.address?.city{
                city = currentCity
            }
            if let currentState = contact?.address?.state{
                state = currentState
            }
            if let currentZipcode = contact?.address?.postalCode{
                zipcode = currentZipcode
            }
            if let currentCountry = contact?.address?.country{
                country = currentCountry
            }
        })
    }
}

    }
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
