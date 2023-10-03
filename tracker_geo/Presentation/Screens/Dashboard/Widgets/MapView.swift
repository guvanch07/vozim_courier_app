//
//  MapView.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 11.08.23.
//

import SwiftUI
import MapKit

class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    @Published var userLocation: CLLocationCoordinate2D?
    private var currentRoute = CurrentRoutesViewModel()
    @Published var locations = [Location]()
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        handleLocations()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        userLocation = location.coordinate
    }
    
    func handleLocations(){
        for route in currentRoute.listReceipts{
            let location = Location(name: route.address.street, coordinate: CLLocationCoordinate2D(latitude: route.address.lat, longitude: route.address.lng));
            self.locations.append(location)
        }
    }
}

extension CLLocationCoordinate2D: Identifiable {
    public var id: String {
        "\(latitude)-\(longitude)"
    }
}
struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

