//
//  DashboardScreen.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 4.08.23.
//

import SwiftUI
import CoreLocation
import _MapKit_SwiftUI

struct DashboardScreen: View {
    @State private var tab = "Список"
    @StateObject private var vm = CurrentRoutesViewModel()
    var colors = ["Список", "Карта","Выполнено"]
    
    var body: some View {
        NavigationStack {
            TabItem(tab:tab)
                .navigationTitle("Маршрут")
                .safeAreaInset(edge: .top) {
                    Picker("Where", selection: $tab) {
                        ForEach(colors, id: \.self) {
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                        .padding([.horizontal, .bottom], 15)
                        .background(Color(uiColor: .systemGroupedBackground))
                        .controlSize(.large)
                }
        }
        .tabItem {
            Label("Home", systemImage: "house")
        }
        .toolbar(.visible, for: .navigationBar)
        .toolbarBackground(
            Color.white.opacity(0.4),
            for: .tabBar)
    }
}

struct DashboardScreen_Previews: PreviewProvider {
    static var previews: some View {
        DashboardScreen()
    }
}

struct TabItem: View {
    let tab: String
    var body: some View {
        switch tab {
        case "Список":
            DeliveryListWidget()
        case "Карта":
            MapView()
        case "Выполнено":
            DoneRoutesScreen()
        default:
            DeliveryListWidget()
        }
    }
}


struct MapView: View {
    @StateObject var viewModel = MapViewModel()
    @State private var trackingMode: MapUserTrackingMode = .follow
    @State private var region: MKCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), // Default to San Francisco
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    var body: some View {
        Map(coordinateRegion: $region,
            interactionModes: .all,
            showsUserLocation: true,
            userTrackingMode: $trackingMode,
            annotationItems: viewModel.locations) { location in
            MapAnnotation(coordinate: location.coordinate) {
                VStack {
                    Image(systemName: "mappin.circle.fill")
                        .foregroundColor(.blue)
                        .imageScale(.large)
                    Text(location.name)
                }
            }
        }
            .onAppear {
                if let userLocation = viewModel.userLocation {
                    region.center = userLocation
                }
            }
    }
}
