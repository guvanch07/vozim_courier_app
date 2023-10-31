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
                image: "barcode",
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
                    image: "from_delivery", title: receipt.isDelivery
                    ? receipt.sender.address.street
                    : receipt.receiver.address.street,
                    subtitle: receipt.isPickUp
                    ? receipt.sender.address.street
                    : receipt.receiver.address.street,
                    replace: receipt.isDelivery,
                    size:(24,42)
                )
                if !receipt.deliveryTime.from.isEmpty ||
                    !receipt.deliveryTime.to.isEmpty {
                    AppListTile(image: "clock", title: "\(receipt.deliveryTime.from.isEmpty ? "" : "с \(receipt.deliveryTime.from)")\(receipt.deliveryTime.to.isEmpty ? "" : " до \(receipt.deliveryTime.to)")")
                }
            }
            .headerProminence(.increased)
            if receipt.pointType == 1 {
                userInfoView(info: receipt.sender)
            }
            if receipt.pointType == 2{
                userInfoView(info: receipt.receiver)
            }
            if receipt.pointType != 3 {
                Section(header: Text("Отправление / груз")) {
                    AppListTile(
                        image: "boxes",
                        title: receipt.goodName,
                        subtitle: "\(receipt.sizes[0].l)x\(receipt.sizes[0].w)x\(receipt.sizes[0].h), \(receipt.goodCount),единиц \(receipt.sizes[0].kg) кг"
                    )
                    if(!receipt.additional.isEmpty){
                        AppListTile(image: "chat_text", title: receipt.additional)
                    }
                    if(isEnable()){
                        InfoChips(data: receipt)
                    }
                }.headerProminence(.increased)
                
                Section(header: Text("Заказчик")) {
                    AppListTile(
                        image: receipt.client.isCompany ? "buildings" : "user",
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
    }
    func pointLabel(type:Int)-> String{
        switch type {
        case 1: "забор";
        case 2: "доставка";
        case 3: "заезд на склад";
        default: "";
        }
    }
    func statusUser(point: Int)-> String{
        switch point {
        case 1:"Отправитель"
        case 2:"Получатель"
        default:""
        }
    }
    func isEnable()-> Bool{
        return receipt.services.driverHelp.enabled
        || receipt.fragile || receipt.services.loader.enabled ||
        (!receipt.deliveryTime.from.isEmpty ||
         !receipt.deliveryTime.to.isEmpty)
    }
    
    func userInfoView(info: Receiver) -> some View{
        Section(header: Text(statusUser(point: receipt.pointType))) {
            AppListTile(
                image: "buildings",
                title: receipt.client.isCompany
                ? "Юридическое лицо"
                : "Физическое лицо",
                subtitle: info.companyName,
                replace: true
            )
            AppListTile(image: "user", title: info.name)
            if !info.additional.isEmpty{
                AppListTile(image: "chat_text", title: info.additional)
            }
            if receipt.payment > 0{
                AppListTile(image: "rubl", title: "\(receipt.payment) \(receipt.currency)")
            }
            Button{
                let telephone = "tel://"
                let formattedString = telephone + (info.phone)
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
    }
}


