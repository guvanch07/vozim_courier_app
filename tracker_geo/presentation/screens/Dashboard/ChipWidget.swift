//
//  ChipWidget.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 5.08.23.
//

import SwiftUI

struct ChipWidget: View {
    var titleKey: String
    var count: Int?
    var body: some View {
        
        HStack() {
            if count != nil {
                Image(systemName: "\(count!).circle.fill")
                    .resizable()
                    .font(.title2)
                    .frame(width: 14.0, height: 14.0)
            }
            Text(titleKey).font(.system(size: 14))
        }
        .padding(.vertical, 5)
        .padding(.leading, 8)
        .padding(.trailing, 8)
        .foregroundColor(.black)
        .background(Color(hex: 0xFFF5F5F5))
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke( lineWidth: 0.1)
            
        )
        
    }
}

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}
