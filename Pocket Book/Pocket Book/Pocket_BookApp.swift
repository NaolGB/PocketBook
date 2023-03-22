//
//  Pocket_BookApp.swift
//  Pocket Book
//
//  Created by Naol Basaye on 3/21/23.
//

import SwiftUI
import Firebase

@main
struct Pocket_BookApp: App {
    @StateObject var dataStore = DataStore()
    
    init () {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            Login()
                .environmentObject(dataStore)
        }
    }
}
