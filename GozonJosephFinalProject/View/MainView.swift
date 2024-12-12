//
//  ContentView.swift
//  GozonJosephFInalProject
//
//  Created by Joseph Gozon on 12/6/24.
//

import SwiftUI

struct MainView: View {
    @StateObject var authViewModel: AuthViewModel
    @StateObject var userVM: UserViewModel
    
    init() {
        let authViewModel = AuthViewModel()
        
        _authViewModel = StateObject(wrappedValue: authViewModel)
        _userVM =  StateObject(wrappedValue: UserViewModel(authVM: authViewModel))
    }
    
    var body: some View {
        if authViewModel.currentUser == nil {
            LoginView(authViewModel: authViewModel)
        } else {
            if let user = authViewModel.currentUser {
                NavBarView(authViewModel: authViewModel, userViewModel: userVM)
            }
        }
    }
}

#Preview {
    MainView()
}
