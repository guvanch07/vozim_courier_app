//
//  tracker_geoApp.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 19.07.23.
//

import SwiftUI

@main
struct tracker_geoApp: App {
    
    @StateObject var userStateViewModel = LoginViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
            .environmentObject(userStateViewModel)
            
        }
    }
}
