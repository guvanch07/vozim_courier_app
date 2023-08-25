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
                StartT0WorkButton(isStarted: false,id: data.id)
            }else{
                InfoChips(data: data)
            }
        }
    }
}




