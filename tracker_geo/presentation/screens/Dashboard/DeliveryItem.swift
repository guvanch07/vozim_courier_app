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
                InfoChips(data: data)
            }
        }
    }
}



