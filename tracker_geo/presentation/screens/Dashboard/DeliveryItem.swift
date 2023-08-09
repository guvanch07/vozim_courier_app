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
    
        let rows = [
            GridItem(.fixed(32)),
            GridItem(.fixed(32))]
    
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
                VStack{
                    Text(data.goodName)
                        .font(.system(size: 14))
                        .foregroundStyle(.gray)
                    HStack{
                        List{
                            ForEach (data.sizes){ i in
                                Text("\(i.h)")
                                    .font(.system(size: 14))
                                    .foregroundStyle(.gray)
                            }
                        }
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
                ScrollView(.horizontal) {
                            LazyHGrid(rows: rows, alignment: .center) {
                                ForEach(listChips, id: \.self) { item in
                                    ChipWidget(titleKey: item, isSelected: item == "Грузчики",count: 2)
                                   
                                }
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

