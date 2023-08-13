//
//  DashboardScreen.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 4.08.23.
//

import SwiftUI
import CoreLocation

struct DashboardScreen: View {
    @State private var tab = "Список"
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
            MapTab()
        case "Выполнено":
            DeliveryListWidget()
        default:
            DeliveryListWidget()
        }
    }
}

struct MapTab: View{
    @StateObject var mapData = MapViewModel()
       @State var locationManager = CLLocationManager()
    var body: some View{
        MapView()
            .environmentObject(mapData)
            .ignoresSafeArea(.all,edges: .all)
            .onAppear(perform: {
                locationManager.delegate = mapData
                locationManager.requestWhenInUseAuthorization()
            })
            .alert(isPresented: $mapData.permissionDenided,
                   content: {
                Alert(title: Text("Permission Denided"),
                      message: Text("Please Enable Permission In App Settings"),
                      dismissButton: .default(Text("Goto Settings"),
                                              action: {
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                }))
                
            })
    }
}
