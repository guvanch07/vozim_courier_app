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
        private let geuTrack = GeoTrackUseCase()

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
                            sendGeoTrack(loc:loc)
                            print("Location \(self.count): \(self.lastLocation)")
                        }
                    }
                } catch {
                    print("Could not start location updates")
                }
                return
            }
        }
    func sendGeoTrack(loc: CLLocation)  {
        Task{
            do{
                let routeId = UserDefaults.standard.string(forKey: "routeId") ?? ""
                logger.info("\(routeId)")
                let geo = Geo(id: count, lat: loc.coordinate.latitude,
                              lng: loc.coordinate.latitude
//                              acu: loc.horizontalAccuracy, spd: loc.speed,
//                              acs: loc.speedAccuracy, hdn: loc.altitude,
//                              ach: 0, alt: loc.altitude,
//                              aca: loc.ellipsoidalAltitude, act: loc.timestamp.currentTimeMillis(),
//                              note: "\(String(describing: loc.sourceInformation))",
//                              flr: loc.floor?.level
                )
                let request = GeoTrackRequest(
                    event: "swiftGeoTrtack",
                    id: routeId,
                    geo: geo
                )
                let track = try await geuTrack.execute(request: request)
//                logger.log("\(track.success ?? false)")
//                logger.info("\(self.manager.heading?.magneticHeading ?? 0)")
//                logger.info("\(self.manager.heading?.headingAccuracy ?? 0)")
//                logger.info("\(self.manager.heading?.trueHeading ?? 0)")
            }catch{
                logger.error("\(error)")
            }
        }
    }
    
        func stopLocationUpdates() {
            print("Stopping location updates")
            self.updatesStarted = false
            self.updatesStarted = false
        }
    
    
    }

extension Date {
    func currentTimeMillis() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}

