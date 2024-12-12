//
//  LoginView.swift
//  GozonJosephFInalProject
//
//  Created by Joseph Gozon on 12/9/24.
//

import Foundation
import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
import Firebase
import FirebaseAuth

struct LoginView: View {
    @ObservedObject var authViewModel: AuthViewModel
    @State var email: String = "gozon@usc.edu"
    @State var password: String = "sandro123"
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 15) {
                // Email Field
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                
                // Password Field
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                // Error Message
                if let errorMessage = authViewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                }
                
                // Login Button
                Button(action: {
                    Task {
                        await authViewModel.signIn(email: email, password: password)
                    }
                }, label: {
                    Text("Login")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                })
                GoogleSignInButton {
                    guard let clientID = FirebaseApp.app()?.options.clientID else { return }

                    // Create Google Sign In configuration object.
                    let config = GIDConfiguration(clientID: clientID)
                    GIDSignIn.sharedInstance.configuration = config

                    // Start the sign in flow!
                    GIDSignIn.sharedInstance.signIn(withPresenting: getRootViewController()) { result, error in
                      guard error == nil else {
                        return
                      }

                      guard let user = result?.user,
                        let idToken = user.idToken?.tokenString
                      else {
                        return
                      }

                      let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                                     accessToken: user.accessToken.tokenString)

                      // ...
                        
                        Auth.auth().signIn(with: credential) { result, error in
                            guard error == nil else {
                                print("firebase google auth error")
                                return
                            }
                            print("google sign in")
                        }
                    }
                }
                
                // Forgot Password
                Button("Forgot Password?") {
                    // TODO: Implement password reset
                }
                .foregroundColor(.blue)
                NavigationLink {
                    RegisterView()
                } label: {
                    Label("New? Register here", systemImage: "pencil")
                }
            }
        }
    }
}

