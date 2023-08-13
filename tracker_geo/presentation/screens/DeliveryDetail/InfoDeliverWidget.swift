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
        List {
            AppListTile(
                image: "barcode.viewfinder",
                title: !receipt.isStock ? "\(receipt.series)-\(receipt.number)" : "",
                view: AnyView(
                    ChipWidget(
                        titleKey: pointLabel(type: receipt.pointType),
                        color: receipt.isDelivery
                        ? appAccent2Color
                        : appAccentColor
                    )
                )
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
            
            Section(header: Text(receipt.onlyDelivery ? "Получатель" : "Отправитель")) {
                AppListTile(
                    image: "building.2",
                    title: receipt.client.isCompany
                            ? "Юридическое лицо"
                            : "Физическое лицо",
                    subtitle: receipt.sender.companyName,
                    replace: true
                )
                AppListTile(image: "person", title: receipt.onlyDelivery ? receipt.receiver.name : receipt.sender.name)
                AppListTile(image: "text.bubble", title: receipt.onlyDelivery ? receipt.receiver.additional : receipt.sender.additional)
                if receipt.payment > 0{
                    AppListTile(image: "dollarsign", title: "\(receipt.payment) \(receipt.currency)")
                }
                Button{
                    let telephone = "tel://"
                    let formattedString = telephone + (receipt.onlyDelivery ? receipt.receiver.phone : receipt.sender.phone)
                        guard let url = URL(string: formattedString) else { return }
                        UIApplication.shared.open(url)
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
                    .background(appSuccessColor)
                    .cornerRadius(24)
            }
            .headerProminence(.increased)
            
            if receipt.pointType != 3 {
                Section(header: Text("Отправление / груз")) {
                    AppListTile(
                        image: "box.truck",
                        title: receipt.goodName,
                        subtitle: "\(receipt.sizes[0].l)x\(receipt.sizes[0].w)x\(receipt.sizes[0].h), \(receipt.goodCount),единиц \(receipt.sizes[0].kg) кг"
                    )
                    AppListTile(image: "text.bubble", title: receipt.additional)
                    InfoChips(data: receipt)
                }.headerProminence(.increased)
            }
           
            
            Section(header: Text("Заказчик")) {
                AppListTile(
                    image: receipt.client.isCompany ? "building.2" : "person",
                    title: receipt.client.isCompany
                    ? "Юридическое лицо"
                    : "Физическое лицо",
                    subtitle: receipt.client.name,
                    replace: true
                )
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


