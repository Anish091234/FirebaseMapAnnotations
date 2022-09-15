//
//  ContentView.swift
//  FullFirebaseMapAnnotations
//
//  Created by Anish Rangdal on 9/11/22.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    @State private var selection = 0
    
    var body: some View {
        TabView {
            ListFirebaseView()
                .tabItem {
                    Label("Map", systemImage: "map.circle")
                }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
