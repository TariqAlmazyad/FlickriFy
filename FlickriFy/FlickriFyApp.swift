//
//  FlickriFyApp.swift
//  FlickriFy
//
//  Created by Tariq Almazyad on 11/30/20.
//

import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("Setting up firebase")
        FirebaseApp.configure()
        Auth.auth().signInAnonymously()
        LocationManager.shared.requestLocationAccess()
        LocationManager.shared.startUpdating()
        return true
    }
}

@main
struct FlickriFyApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().barStyle = .black
        LocationManager.shared.requestLocationAccess()
        LocationManager.shared.startUpdating()
    }
    
    var body: some Scene {
        WindowGroup {
            RootView{
                HomeView()
                    .preferredColorScheme(.dark)
            }
        }
    }
}
