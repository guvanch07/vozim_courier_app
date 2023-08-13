//
//  DeliveryItem.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 4.08.23.
//

import SwiftUI

struct DeliveryItem: View {
    let data: Receipt
    let isFirst: Bool
    
    let row2 = [
        GridItem(.fixed(30)),
        GridItem(.fixed(30))]

let row1 = [
    GridItem(.fixed(30))
]
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: 12
        ){
            HStack{
                Image(systemName: "box.truck")
                Text(data.address.street)
                    .bold()
                    .font(.system(size: 18))
            }
            HStack(
                alignment: .top
            ){
                Image(systemName: "box.truck")
                VStack(
                    alignment: .leading
                ){
                    Text(data.goodName.trimmingCharacters(in: .whitespacesAndNewlines))
                        .font(.system(size: 14))
                        .foregroundStyle(.gray)
                        
                    ForEach(data.sizes) { size in
                        Text("\(size.w)x\(size.h)X\(size.l) см, \(size.kg) кг")
                            .font(.system(size: 14))
                            .foregroundStyle(.gray)
                    }
                }
            }
            if isFirst{
                Button {
                    print(UserDefaults.standard.string(forKey: "token") ?? "")
                }
            label: {
                HStack(spacing: 5){
                    Text("Открыть в навигаторе")
                        .foregroundStyle(appAccentColor)
                    Image(systemName: "arrow.right")
                        .foregroundColor(appAccentColor)
                }.padding([.horizontal],10)
                    .padding([.vertical],5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(appAccentColor, lineWidth: 1)
                    )
            }
            }else{
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
    }
}

let listChips = [
    "Помощь водителя",
    "Хрупкий груз",
    "Грузчики",
    "с 11:00 до 15:00"
]

