//
//  InfoChips.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 13.08.23.
//

import SwiftUI

struct InfoChips: View {
    let data: Receipt
    
    let row2 = [
        GridItem(.fixed(30)),
        GridItem(.fixed(30))]
    
    let row1 = [
        GridItem(.fixed(30))
    ]
    
    var body: some View {
        LazyHGrid(rows: data.services.driverHelp.enabled && data.fragile ?
                  row2
                  : data.services.loader.enabled &&
                  (!data.deliveryTime.from.isEmpty ||
                   !data.deliveryTime.to.isEmpty)
                  ? row1
                  :[],
                  alignment: .center) {
            if !data.deliveryTime.from.isEmpty ||
                !data.deliveryTime.to.isEmpty{
                ChipWidget(titleKey: "c \(data.deliveryTime.from) до \(data.deliveryTime.to)")
            }
            if data.services.loader.enabled {
                ChipWidget(titleKey: "Грузчики",count: data.services.loader.count)
            }
            if data.services.driverHelp.enabled {
                ChipWidget(titleKey: "Помощь водителя")
            }
            if data.fragile {
                ChipWidget(titleKey: "Хрупкое")
            }
        }
    }
}


let listChips = [
    "Помощь водителя",
    "Хрупкий груз",
    "Грузчики",
    "с 11:00 до 15:00"
]
