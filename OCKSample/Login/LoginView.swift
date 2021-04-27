//
//  LoginView.swift
//  OCKSample
//
//  Created by Corey Baker on 10/29/20.
//  Copyright © 2020 Network Reconnaissance Lab. All rights reserved.
//

// This is a variation of the tutorial found here: https://www.iosapptemplates.com/blog/swiftui/login-screen-swiftui

import SwiftUI
import ParseSwift
//import UIKit

struct LoginView: View {
    
    //Anything is @ is a wrapper that subscribes and refreshes the view when a change occurs.
    @ObservedObject private var login = Login()
    @State private var presentMainScreen = false
    @State var username: String = ""
    @State var password:String = ""
    @State var firstName: String = ""
    @State var lastName:String = ""
    @State var email: String = ""
    @State var StateView = 0
    var body: some View {

        if login.isLoggedIn {
            MainView()
        }
        else { VStack() {
       //    background(Color.blue)
                Text("Welcome to Health Tracker")
                    .font(.title)
                    .foregroundColor(Color(.red))
                Text("sign up to get started")
                    .font(.headline)
                    .foregroundColor(Color(.red))
                Image("gymIcon.png")
                    .resizable()
                    .frame(width: 200, height: 200, alignment: .center)
                    //.clipShape(Circle())
              //      .overlay(Square().stroke(Color(#colorLiteral(red: 0, green: 0.2858072221, blue: 0.6897063851, alpha: 1) ),lineWidth: 6))
                    
                    .shadow(radius: 2)
                //Notice that "action" is a closure (which is essentially a function as an argument)
            TextField("username",text: $username)
                .padding()
               // .background()
            SecureField("Password",text: $password)
                .padding()
                Button(action: {
                    login.login(username: username,password: password)
                
                }, label: {
                    Text("Login")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 300, height: 50)
                })
                .background(Color(.red))
                .cornerRadius(15)
                //If error occurs show it on the screen
            
                Button(action: {
          //          login.loginAnonymously()
                 //   StateView = 1
                }, label: {
                    Text("Sign Up")
                })
          
                
                if let error = login.loginError {
                    Text("Error: \(error.message)")
                        .foregroundColor(.red)
                }
                
              //  Spacer()
            }
        if StateView == 1{
    //        @ObservedObject private var login = Login()
 /*           @State private var presentMainScreen = false
            @State var firstName: String = ""
            @State var lastName:String = ""
            @State var username: String = ""
            @State var email: String = ""
            @State var password:String = ""
            */
               //var body: some View{
             
                VStack(){
                 //   Text("Click Create Account to finish signing up")
                   //     .padding()
                    TextField("First Name", text: $firstName)
                        .padding()
                    TextField("Last Name", text: $lastName)
                        .padding()
                    TextField("username",text: $username)
                        .padding()
                    TextField("Email",text: $email)
                        .padding()
                       // .background()
                    SecureField("Password",text: $password)
                        .padding()
                    Button(action: {
                       login.signup(firstName: firstName, lastName: lastName, username: username, password: password)
                     //   login.login(username: username, password: password)
                    }, label: {
                        Text("Create Account")
                    })
                        Spacer()
                }
        }
       
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct signupView:View{
   // @ObservedObject private var signup = signup()
    @ObservedObject private var login = Login()
    @State private var presentMainScreen = false
    @State var firstName: String = ""
    @State var lastName:String = ""
    @State var username: String = ""
    @State var email: String = ""
    @State var password:String = ""
    
        var body: some View{
     
        VStack{
        
            TextField("First Name", text: $firstName)
                .padding()
            TextField("Last Name", text: $lastName)
                .padding()
            TextField("username",text: $username)
                .padding()
            TextField("Email",text: $email)
                .padding()
               // .background()
            SecureField("Password",text: $password)
                .padding()
            Button(action: {
                login.signup(firstName: firstName, lastName: lastName, username: username, password: password)
            }, label: {
                Text("Sign up")
            })
            
        }
    }
}
struct signupView_Previews: PreviewProvider {
    static var previews: some View {
        signupView()
    }
}

