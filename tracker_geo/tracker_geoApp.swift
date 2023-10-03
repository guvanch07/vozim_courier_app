//
//  tracker_geoApp.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 19.07.23.
//

import SwiftUI


@available(iOS 17.0, *)
@main
struct tracker_geoApp: App {
   
        @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    
    
    @StateObject var userStateViewModel = LoginViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
            .environmentObject(userStateViewModel)
        }
    }
}
