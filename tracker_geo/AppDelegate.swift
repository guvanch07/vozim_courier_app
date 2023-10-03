//
//  AppDelegate.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 1.10.23.
//

import Foundation
import os
import UIKit

@available(iOS 17.0, *)
class AppDelegate: NSObject, UIApplicationDelegate, ObservableObject {
    
    let logger = Logger(subsystem: "com.apple.tracker_geo", category: "AppDelegate")
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions
                     launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        let locationsHandler = LocationsHandler.shared
        
        // If location updates were previously active, restart them after the background launch.
        if locationsHandler.updatesStarted {
            self.logger.info("Restart liveUpdates Session")
            locationsHandler.startLocationUpdates()
        }
        // If a background activity session was previously active, reinstantiate it after the background launch.
        if locationsHandler.backgroundActivity {
            self.logger.info("Reinstantiate background activity session")
            locationsHandler.backgroundActivity = true
        }
        return true
    }
}

