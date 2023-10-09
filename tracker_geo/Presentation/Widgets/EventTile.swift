//
//  EventTile.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 9.10.23.
//

import SwiftUI

struct EventTile: View {
    let title: String
    let stripeHeight = 15.0
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Image(systemName: "info.circle")
                .font(.title)
            Text(title)
        }
        .padding()
        .padding(.top, stripeHeight)
        .background {
            ZStack(alignment: .top) {
                Rectangle()
                    .opacity(0.3)
                Rectangle()
                    .frame(maxHeight: stripeHeight)
            }
            .foregroundColor(.teal)
        }
        .clipShape(RoundedRectangle(cornerRadius: stripeHeight, style: .continuous))
    }
}

#Preview {
    EventTile(title: "")
}
