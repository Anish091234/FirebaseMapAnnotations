//
//  FullFirebaseMapAnnotationsApp.swift
//  FullFirebaseMapAnnotations
//
//  Created by Anish Rangdal on 9/11/22.
//

import SwiftUI
import Firebase

@main
struct FullFirebaseMapAnnotationsApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
