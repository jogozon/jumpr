//
//  TabView.swift
//  GozonJosephFInalProject
//
//  Created by Joseph Gozon on 12/10/24.
//

import Foundation
import SwiftUI

struct NavBarView: View {
    @ObservedObject var authViewModel: AuthViewModel
    @ObservedObject var userViewModel: UserViewModel
    
    var body: some View {
        TabView {
            MapView()
                .tabItem {
                    Label("Home", systemImage: "map")
                }
            AddGameView(user: authViewModel.currentUser!, userVM: userViewModel)
                .tabItem {
                    Label("Add", systemImage: "pencil.line")
                }
            GameListView(userViewModel: userViewModel)
                .tabItem {
                    Label("Feed", systemImage: "bubble")
                }
            ProfileView(user: authViewModel.currentUser!)
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
    }
}

//#Preview {
//    NavBarView()
//}
