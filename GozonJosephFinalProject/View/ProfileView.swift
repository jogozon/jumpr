//
//  ProfileView.swift
//  GozonJosephFInalProject
//
//  Created by Joseph Gozon on 12/9/24.
//

import Foundation
import SwiftUI
import PhotosUI

struct ProfileView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    var user: UserModel
    
    @State private var bio: String = "Love playing basketball! 🏀"
    @State private var username = ""
    @State private var gamesPlayed = [
        "Pickup Game at Central Park",
        "3v3 Tournament Finals",
        "Sunday Morning Scrimmage"
    ]
    @State private var isEditing = false
    
//    init() {
//        print("cool beans")
//    }

    var body: some View {
        NavigationView {
            VStack {
                // Avatar and Info
                VStack {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.blue)
                        .padding(.top, 20)

                    Text("\(String(describing: user.firstName))  \(String(describing: user.lastName))")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top, 5)

                    Text(bio)
                        .font(.body)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .padding(.top, 2)
                    HStack {
                        Button(action: {
                            isEditing.toggle()
                        }) {
                            Text("Edit Profile")
                                .font(.headline)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding(.horizontal)
                        }
                        .sheet(isPresented: $isEditing) {
                            EditProfileView(username: $username, bio: $bio)
                        }
                        Button(action: {
                            authViewModel.signOut()
                        }) {
                            Text("Logout")
                                .font(.headline)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding(.horizontal)
                        }
                    }
                    
                }
                .padding()

                // Games Played
                VStack(alignment: .leading) {
                    Text("Games Played")
                        .font(.headline)
                        .padding(.leading)
                        .padding(.top, 10)

                    List(gamesPlayed, id: \.self) { game in
                        HStack {
                            Image(systemName: "basketball.fill")
                                .foregroundColor(.orange)
                            Text(game)
                        }
                    }
                    .listStyle(PlainListStyle())
                }

                Spacer()
            }
            .navigationTitle("\(user.displayName)")
        }
    }
}

struct EditProfileView: View {
    @Binding var username: String
    @Binding var bio: String

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Username")) {
                    TextField("Enter your username", text: $username)
                }

                Section(header: Text("Bio")) {
                    TextField("Enter your bio", text: $bio)
                }
            }
            .navigationTitle("Edit Profile")
            .navigationBarItems(
                trailing: Button("Done") {
                    // Dismiss the sheet
                    UIApplication.shared.windows.first?.rootViewController?.dismiss(animated: true, completion: nil)
                }
            )
        }
    }
}



//#Preview {
//    ProfileView(user: UserModel(uid: "UUID()", firstName: "Joseph", lastName: "Gozon", displayName: "jogoz", email: "goz@usc.edu", profileUrl: ""))
//}
