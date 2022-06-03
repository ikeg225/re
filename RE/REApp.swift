//
//  REApp.swift
//  RE
//
//  Created by Ethan Ikegami on 6/1/22.
//

import SwiftUI
import Firebase

@main
struct REApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
        }
    }
}
