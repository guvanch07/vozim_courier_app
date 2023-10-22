//
//  NavigatorButton.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 15.10.23.
//

import SwiftUI

struct NavigatorButton: View {
    var body: some View {
        Button(
            action: {
                print(UserDefaults.standard.string(forKey: "token") ?? "")
            }, label: {
                HStack(spacing: 5){
                    Text("Открыть в навигаторе")
                        .foregroundStyle(appAccentColor)
                    Image(systemName: "arrow.right")
                        .foregroundColor(appAccentColor)
                }.padding(.horizontal,20)
                    .padding(.vertical,7)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(appAccentColor, lineWidth: 1)
                    )
            }
        )
        .onTapGesture {
            print(UserDefaults.standard.string(forKey: "token") ?? "")
        }
    }
}

#Preview {
    NavigatorButton()
}
