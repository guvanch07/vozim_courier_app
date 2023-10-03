//
//  MainDetailWidget.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 13.08.23.
//

import SwiftUI

struct MainDetailWidget: View {
    let receipt: Receipt
    @State private var tab = "Информация"
    var colors = ["Информация", "Карта"]
    
    var body: some View {
       
        VStack{
            Picker("Where", selection: $tab) {
                ForEach(colors, id: \.self) {
                    Text($0)
                }
            }.pickerStyle(.segmented)
                .padding([.top,.trailing,.leading],15)
                .background(Color(uiColor: .systemGroupedBackground))
                .controlSize(.large)
            
            TabDetailItem(receipt: receipt, tab: tab)
            AnimatedButton {
                HStack{
                    Spacer()
                    Text("Начать")
                    Spacer()
                }
                .foregroundColor(.black)
            } action: {
                try? await Task.sleep(for: .seconds(1))
                return .success
            }
            .padding(.horizontal, 15)
            .padding(.bottom,7)

        }
    }
}



struct TabDetailItem: View {
    let receipt: Receipt
    let tab: String
    var body: some View {
        switch tab {
        case "Информация":
            InfoDeliverWidget(receipt: receipt)
        case "Карта":
            if #available(iOS 17.0, *) {
                LocationMap(receipt: receipt)
            } else {
                MapView()
            }
        default:
            Text("sth wrong")
        }
    }
}
