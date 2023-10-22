//
//  HomeScreen.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 4.08.23.
//

import SwiftUI

struct HomeScreen: View {
    var body: some View {
        TabView {
            DashboardScreen()
            CargoScreen()
            ProfileScreen()
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
//                ProfileView().tabItem {
//                    Label("Профиль", systemImage: "person").labelStyle(.iconOnly)
//                }
