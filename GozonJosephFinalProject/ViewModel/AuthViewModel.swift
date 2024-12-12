//
//  AuthViewModel.swift
//  GozonJosephFInalProject
//
//  Created by Joseph Gozon on 12/9/24.
//

import Foundation
import FirebaseAuth
import FirebaseCore
import GoogleSignIn

class AuthViewModel: ObservableObject {
    // Published properties for UI binding
    @Published var userSession: User?
    @Published var currentUser: UserModel?
    @Published var errorMessage: String?
    private var handler: AuthStateDidChangeListenerHandle?
    
    init() {
        // Listen for authentication state changes
        observeAuthenticationState()
    }
    
    // handle user auth in the root view
    private func observeAuthenticationState() {
        self.handler = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                self.userSession = user
                self.fetchUser(uid: user.uid)
            } else {
                self.currentUser = nil
            }
        }
    }
    
    private func fetchUser(uid: String) {
        let docRef = COLLECTION_USERS.document(uid)
        
        docRef.getDocument(as: UserModel.self) { result in
            switch result {
            case .success(let user):
                self.currentUser = user
                self.errorMessage = nil
            case .failure(let error):
                self.errorMessage = "Error decoding document: \(error.localizedDescription)"
            }
        }
    }
    
    func signIn(email: String, password: String) async {
        do {
            try await Auth.auth().signIn(withEmail: email, password: password)
        } catch {
            print(error)
        }
    }
    
    func register(firstName: String, lastName: String, displayName: String, password: String, email: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (res, error) in
            guard let res else {
                print("Failed to register")
                return
            }
            
            self.userSession = res.user
            do {
                try COLLECTION_USERS.document(res.user.uid).setData(from: self.currentUser)
            } catch {
                print(error)
            }
            
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
    }
    

    
}
