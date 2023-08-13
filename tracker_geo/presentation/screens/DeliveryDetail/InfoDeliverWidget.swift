//
//  InfoDeliverWidget.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 13.08.23.
//

import SwiftUI

struct InfoDeliverWidget: View {
    let receipt: Receipt
    var body: some View {
        List() {
            AppListTile(
                image: "barcode.viewfinder",
                title: receipt.pointType != 3 ? "\(receipt.series)-\(receipt.number)" : "",
                view: AnyView(
                    ChipWidget(
                        titleKey: pointLabel(type: receipt.pointType),
                        color: receipt.pointType == 2
                        ? Color(hex: 0xFF69D9E2)
                        : Color(hex: 0xFFFFA45B)))
            )
            
            Section(header: Text("Адрес")) {
                AppListTile(
                    image: "mappin.circle", title: receipt.isDelivery
                            ? receipt.sender.address.street
                            : receipt.receiver.address.street,
                            subtitle: receipt.isPickUp
                            ? receipt.sender.address.street
                            : receipt.receiver.address.street,
                replace: receipt.isDelivery
                )
                if !receipt.deliveryTime.from.isEmpty ||
                    !receipt.deliveryTime.to.isEmpty {
                    AppListTile(image: "clock", title: "\(receipt.deliveryTime.from.isEmpty ? "" : "с \(receipt.deliveryTime.from)")\(receipt.deliveryTime.to.isEmpty ? "" : " до \(receipt.deliveryTime.to)")")
                }
            }
            .headerProminence(.increased)
            
            Section(header: Text("Отправитель")) {
                AppListTile(image: "building.2", title: receipt.client.isCompany ? "Юридическое лицо"
                            : "Физическое лицо",
                            subtitle: receipt.sender.companyName,
                            replace: true
                            
                )
                AppListTile(image: "person", title: receipt.sender.name)
                AppListTile(image: "text.bubble", title: receipt.sender.additional)
                if receipt.payment > 0{
                    AppListTile(image: "dollarsign", title: "\(receipt.payment) \(receipt.currency)")
                }
                Button{
                    print("call")
                }label: {
                    HStack{
                        Image(systemName: "phone")
                        Text("Позвонить")
                            .font(.system(size: 16))
                            .fontWeight(.medium)
                    }
                }.padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .foregroundColor(.white)
                    .background(.green)
                    .cornerRadius(24)
            }
            
            .headerProminence(.increased)
            Section(header: Text("Header")) {
                Text("Row")
            }
            .headerProminence(.increased)
            Section(header: Text("Header")) {
                Text("Row")
                Text("Row")
                Text("Row")
                Text("Row")
            }
            .headerProminence(.increased)
            Section(header: Text("Header")) {
                Text("Row")
            }
            .headerProminence(.increased)
            Section(header: Text("Header")) {
                Text("Row")
            }
            .headerProminence(.increased)
            
        }
    }
    func pointLabel(type:Int)-> String{
        switch type {
        case 1: return "забор";
        case 2:return "доставка";
        case 3:return "заезд на склад";
        default:return "";
        }
    }
}


