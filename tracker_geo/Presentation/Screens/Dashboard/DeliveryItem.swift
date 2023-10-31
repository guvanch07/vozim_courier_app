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
    let itemType: DeliveryItemType
    
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: 12
        ){
            HStack{
                imageHandler()
                Text(data.address.street)
                    .bold()
                    .font(.system(size: 18))
            }
            HStack(alignment: .top){
                Image("boxes")
                    .resizable()
                    .frame(width: 24,height: 24)
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
            if data.isArrived || data.isProgress{
                NavigatorButton()
            }
            else if isFirst{
                if #available(iOS 17.0, *) {
                    StartT0WorkButton(
                        id: data.id,
                        receipt: data)
                } else {
                    // Fallback on earlier versions
                }
            }else{
                InfoChips(data: data)
            }
        }
    }
    func imageHandler() -> AnyView{
        switch itemType {
        case .done:
            AnyView(Image(data.isDelivery ? "done_blue" :"done_yellow")
                .resizable()
                .frame(width: 25,height: 25))
        case .current:
            AnyView(Image(data.isDelivery ? "marker_blue" :"marker_yellow")
                .resizable()
                .frame(width: 25,height: 25))
        default:
            AnyView(Image(systemName: "box.truck"))
        }
    }
}

enum DeliveryItemType{
    case done
    case current
    case cargo
}


