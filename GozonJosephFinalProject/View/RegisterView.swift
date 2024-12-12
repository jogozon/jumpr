//
//  RegisterView.swift
//  GozonJosephFInalProject
//
//  Created by Joseph Gozon on 12/9/24.
//

import Foundation
import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State var email: String = ""
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var password: String = ""
    @State var displayName: String = ""
    @State var profileUrl: String? = nil
    
    var body: some View {
        VStack(spacing: 15) {
            // Display Name Field
            TextField("Display Name", text: $displayName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("First Name", text: $firstName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Last Name", text: $lastName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
//            TextField("Profile Pic", text: $profileUrl)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            
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
            
            // Register Button
            Button(action: {
                authViewModel.register(firstName: firstName, lastName: lastName, displayName: displayName, password: password, email: email)
            }, label: {
                
                Text("Register")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                
            })
        }
    }
}
