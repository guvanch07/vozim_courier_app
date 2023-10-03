//
//  geo_location_service.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 24.07.23.
//

import Foundation
import CoreLocation
import os

// Shared state that manages the `CLLocationManager` and `CLBackgroundActivitySession`.
@available(iOS 17.0, *)
@MainActor class LocationsHandler: ObservableObject {

        let logger = Logger(subsystem: "com.apple.tracker_geo", category: "LocationsHandler")

        static let shared = LocationsHandler()  // Create a single, shared instance of the object.

        private let manager: CLLocationManager
        private var background: CLBackgroundActivitySession?

        @Published var lastLocation = CLLocation()
        @Published var isStationary = false
        @Published var count = 0

        @Published
        var updatesStarted: Bool = UserDefaults.standard.bool(forKey: "liveUpdatesStarted") {
            didSet { UserDefaults.standard.set(updatesStarted, forKey: "liveUpdatesStarted") }
        }

        @Published
        var backgroundActivity: Bool = UserDefaults.standard.bool(forKey: "BGActivitySessionStarted") {
            didSet {
                backgroundActivity ? self.background = CLBackgroundActivitySession() : self.background?.invalidate()
                UserDefaults.standard.set(backgroundActivity, forKey: "BGActivitySessionStarted")
            }
        }


        private init() {
            self.manager = CLLocationManager()  // Creating a location manager instance is safe to call here in `MainActor`.
        }

        func startLocationUpdates() {
            if self.manager.authorizationStatus == .notDetermined {
                self.manager.requestWhenInUseAuthorization()
            }
            self.logger.info("Starting location updates")
            Task() {
                do {
                    self.updatesStarted = true
                    let updates = CLLocationUpdate.liveUpdates()
                    for try await update in updates {
                        if !self.updatesStarted { break }  // End location updates by breaking out of the loop.
                        if let loc = update.location {
                            self.lastLocation = loc
                            self.isStationary = update.isStationary
                            self.count += 1
                            print("Location \(self.count): \(self.lastLocation)")
                        }
                    }
                } catch {
                    print("Could not start location updates")
                }
                return
            }
        }
    
        func stopLocationUpdates() {
            print("Stopping location updates")
            self.updatesStarted = false
            self.updatesStarted = false
        }
    
    
    }


//struct ContentView: View {
//    let logger = Logger(subsystem: "com.apple.liveUpdatesSample", category: "DemoView")
//    @ObservedObject var locationsHandler = LocationsHandler.shared
//    
//    var body: some View {
//        VStack {
//            Spacer()
//            Text("Location: \(self.locationsHandler.lastLocation)")
//                .padding(10)
//            Text("Count: \(self.locationsHandler.count)")
//            Text("isStationary:")
//            Rectangle()
//                .fill(self.locationsHandler.isStationary ? .green : .red)
//                .frame(width: 100, height: 100, alignment: .center)
//            Spacer()
//            Button(self.locationsHandler.updatesStarted ? "Stop Location Updates" : "Start Location Updates") {
//                self.locationsHandler.updatesStarted ? self.locationsHandler.stopLocationUpdates() : self.locationsHandler.startLocationUpdates()
//            }
//            .buttonStyle(.bordered)
//            Button(self.locationsHandler.backgroundActivity ? "Stop BG Activity Session" : "Start BG Activity Session") {
//                self.locationsHandler.backgroundActivity.toggle()
//            }
//            .buttonStyle(.bordered)
//        }
//    }
//}
