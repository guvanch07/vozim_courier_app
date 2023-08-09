//
//  tracker_geoApp.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 19.07.23.
//

import SwiftUI

@main
struct tracker_geoApp: App {
    var body: some Scene {
        WindowGroup {
           
            if UserDefaults.standard.string(forKey: "token") != nil{
                HomeScreen()
            }else{
                LoginScreen()
            }
            
            //ContentView()
        }
    }
}
