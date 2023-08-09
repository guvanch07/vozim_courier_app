//
//  DashboardScreen.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 4.08.23.
//

import SwiftUI

struct DashboardScreen: View {
    @State private var favoriteColor = "Список"
    var colors = ["Список", "Карта","Выполнено"]
    
    var body: some View {
        NavigationStack {
            DeliveryListWidget()
            .navigationTitle("Маршрут")
            .safeAreaInset(edge: .top) {
                Picker("Where", selection: $favoriteColor) {
                    ForEach(colors, id: \.self) {
                        Text($0)
                    }
                }.pickerStyle(SegmentedPickerStyle())
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
