//
//  EventTile.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 9.10.23.
//

import SwiftUI

struct EventTile: View {
    let title: String
    let image: String
    let foregroundColor: Color
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: image)
                .font(.title)
                .foregroundStyle(.white)
            Text(title)
                .foregroundStyle(.white)
            Spacer()
        }
        .padding(.vertical,5)
        .padding(.horizontal,10)
        .background {
            ZStack(alignment: .top) {
                Rectangle()
            }
            .foregroundColor(foregroundColor)
        }
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }
}

