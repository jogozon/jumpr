//
//  GozonJosephFInalProjectApp.swift
//  GozonJosephFInalProject
//
//  Created by Joseph Gozon on 12/6/24.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        GIDSignIn.sharedInstance.configure { error in
             if let error {
               print("Error configuring `GIDSignIn` for Firebase App Check: \(error)")
             }
           }
        return true
    }
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
      return GIDSignIn.sharedInstance.handle(url)
    }
}

@main
struct GozonJosephFInalProjectApp: App {
    
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}

