//
//  LoginViewModel.swift
//  OCKSample
//
//  Created by Corey Baker on 11/24/20.
//  Copyright © 2020 Network Reconnaissance Lab. All rights reserved.
//

import Foundation
import ParseSwift
import CareKit
import CareKitStore

class Login: ObservableObject {

    private(set) var isLoggedIn = false {
        willSet {
            objectWillChange.send() //Publishes a notification to subscribers whenever this value changes
        }
    }
    private(set) var loginError: ParseError? = nil {
        willSet {
            objectWillChange.send() //Publishes a notification to subscribers whenever this value changes
        }
    }
    private var profileModel: Profile?

   
    //MARK: User intentional behavier

    /**
     Logs in the user anonymously *asynchronously*.
    */
    
    func loginAnonymously() {
        
        User.anonymous.login { result in

            switch result {
            
            case .success(let user):
                print("Parse login successful: \(user)")
                    
                self.profileModel = Profile()
                self.profileModel?.savePatientAfterSignUp("Anonymous", last: "Login") { result in
                    switch result {
                    
                    case .success(_):
                        self.isLoggedIn = true //Notify the SwiftUI view that the user is correctly logged in and to transition screens
                        
                        //Setup installation to receive push notifications
                        Installation.current?.save() { result in
                            switch result {
                            
                            case .success(_):
                                print("Parse Installation saved, can now receive push notificaitons.")
                            case .failure(let error):
                                print("Error saving Parse Installation saved: \(error.localizedDescription)")
                            }
                        }
                    case .failure(let error):
                        print("Error saving the patient after signup: \(error)")
                    }
                }
                
            case .failure(let error):
                print("*** Error logging into Parse Server. If you are still having problems check for help here: https://github.com/netreconlab/parse-hipaa#getting-started ***")
                print("Parse error: \(String(describing: error))")
                
                self.loginError = error //Notify the SwiftUI view that there's an error
            }
        }
    }
    
    /**
     This function logs the user into the app by changing the boolean isLoggedIn to true if the user has an account and the password is correct.
     - parameters:
        - username: String entered in the TextField in the signup view
        - password: String entered in the SecureField in the signup view
        
     */
    func login(username:String, password: String){
        User.login(username: username,password: password) { result in
            switch result {
            case .success(let user):
                print("Parse login successful: \(user)")
                self.profileModel = Profile()
                self.profileModel?.setupRemoteAfterLoginButtonTapped { result in
                    switch result {
                    case .success(_):
                        self.isLoggedIn = true //Notify the SwiftUI view that the user is correctly logged in and to transition screens
                        //Setup installation to receive push notifications
                        Installation.current?.save() { result in
                            switch result {
                            case .success(_):
                                print("Parse Installation saved, can now receive push notificaitons.")
                            case .failure(let error):
                                print("Error saving Parse Installation saved: \(error.localizedDescription)")
                            }
                        }
                    case .failure(let error):
                        print("Error saving the patient after signup: \(error)")
                    }
                }
            case .failure(let error):
                print("*** Error logging into Parse Server. If you are still having problems check for help here: https://github.com/netreconlab/parse-hipaa#getting-started ***")
                print("Parse error: \(String(describing: error))")
                self.loginError = error //Notify the SwiftUI view that there's an error
            }
        }
    }
    /**
     This function creates an instance of user by calling the User.signup(username,password). If this fuction is successful the profile is saved as a patient and user. In the case of an error, the function prints an error string.
     - parameters:
        - firstName: String entered in the TextField in the signup view
        - lastName: String entered in the TextField in the signup view
        - username: String entered in the TextField in the signup view
        - password: String entered in the SecureField in the signup view
     
     */

    func signup(firstName: String, lastName: String, username:String, password:String){
        User.signup(username: username ,password: password) { result in
            switch result {
            case .success(let user):
                print("Parse signup successful:\(user)")
           //     self.isLoggedIn = true
                self.profileModel = Profile()
                   self.profileModel?.savePatientAfterSignUp(firstName, last: lastName) { result in
                       switch result{
                           case .success(_):
                               self.isLoggedIn = true
                               Installation.current?.save() { result in
                                   switch result {
                                   
                                   case .success(_):
                                       print("Parse Installation saved, can now receive push notificaitons.")
                                   case .failure(let error):
                                       print("Error saving Parse Installation saved: \(error.localizedDescription)")
                                   }
                               }
                           case .failure(let error):
                               print("Error saving the patient after signup: \(error)")
                       //        self.isLoggedIn = true
                       }
                   }
            case .failure(let error):
                switch error.code{
                case .usernameTaken:
                    self.loginError = error
                    
                default:
                    print("*** signup Error Signing up as user for Parse Server. Are you running parse-hippa and is the initialization complete? Check http://localhost:1337 in your browser. If you are still having problems check here https://github.com/netreconlab/parse-postgres#getting-started ***")
                }
            }
        }
    }
}

