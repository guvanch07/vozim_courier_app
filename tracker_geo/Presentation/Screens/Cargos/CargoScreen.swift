//
//  CargoScreen.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 9.10.23.
//

import SwiftUI

struct CargoScreen: View {
    var body: some View {
        NavigationStack {
            AllCargosScreen()
                .navigationTitle("Грузы")
        }
        .tabItem {
            Label("Грузы", systemImage: "shippingbox").labelStyle(.iconOnly)
        }
        .toolbar(.visible, for: .navigationBar)
        .toolbarBackground(
            Color.white.opacity(0.4),
            for: .tabBar)
    }
}

#Preview {
    CargoScreen()
}
