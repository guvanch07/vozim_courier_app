//
//  ProfileView.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 4.10.23.
//

import SwiftUI

@available(iOS 17.0, *)
struct ProfileView: View {
        @ObservedObject var locationsHandler = LocationsHandler.shared
        var body: some View {
            VStack {
                Spacer()
                Text("Location: \(self.locationsHandler.lastLocation)")
                    .padding(10)
                Text("Count: \(self.locationsHandler.count)")
                Text("isStationary:")
                Rectangle()
                    .fill(self.locationsHandler.isStationary ? .green : .red)
                    .frame(width: 100, height: 100, alignment: .center)
                Spacer()
                Button(self.locationsHandler.updatesStarted ? "Stop Location Updates" : "Start Location Updates") {
                    self.locationsHandler.updatesStarted ? self.locationsHandler.stopLocationUpdates() : self.locationsHandler.startLocationUpdates()
                }
                .buttonStyle(.bordered)
                Button(self.locationsHandler.backgroundActivity ? "Stop BG Activity Session" : "Start BG Activity Session") {
                    self.locationsHandler.backgroundActivity.toggle()
                }
                .buttonStyle(.bordered)
            }
        }
}

#Preview {
    if #available(iOS 17.0, *) {
        ProfileView()
    } else {
        EmptyView()
    }
}
