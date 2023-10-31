//
//  LocationMap.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 2.10.23.
//

import SwiftUI
import MapKit

@available(iOS 17.0, *)
struct LocationMap: View {
    var receipt: Receipt
    @StateObject var viewModel = MapViewModel()
    
    var body: some View {
        Map(
            initialPosition: .camera(MapCamera(
                centerCoordinate: viewModel.userLocation ?? CLLocationCoordinate2D(latitude: 21.273389, longitude: -157.823802),
                distance: 1200,
                heading: 90,
                pitch: 60))) {
                    Marker(receipt.address.street,
                           systemImage: "pin",
                           coordinate: CLLocationCoordinate2D(latitude: receipt.address.lat, longitude: receipt.address.lng))
                    .tint(.blue)
                }
                .mapStyle(.imagery(elevation: .realistic))
                .mapControls {
                    MapPitchToggle()
                    MapUserLocationButton()
                    MapCompass()
                }
        
    }
}


