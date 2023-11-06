//
//  MainDetailWidget.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 13.08.23.
//

import SwiftUI

struct MainDetailWidget: View {
    let isDone: Bool
    let receipt: Receipt
    @State private var tab = "Информация"
    @StateObject private var vm = DetailViewModel()
    var infoTabs = ["Информация", "Карта"]
    var body: some View {
        VStack{
            Picker("Where", selection: $tab) {
                ForEach(infoTabs, id: \.self) {
                    Text($0)
                }
            }.pickerStyle(.segmented)
                .padding([.top,.trailing,.leading],15)
                .background(Color(uiColor: .systemGroupedBackground))
                .controlSize(.large)
            
            if (isDone){
                EventTile(
                    title: "Выполнено",
                    image: "checkmark.circle",
                    foregroundColor: .green).padding(.horizontal,15)
            }else if vm.startToWorkSucces?.success ?? false{
                EventTile(
                    title: "Бесплатное ожидание 14:59",
                    image: "info.circle",
                    foregroundColor: .teal).padding(.horizontal,15)
            }
            
            TabDetailItem(receipt: receipt,isDone: isDone, tab: tab)
            if #available(iOS 17.0, *) {
                if !isDone {
                    AnimatedButton {
                        HStack{
                            Spacer()
                            Text(actionButtonText())
                            Spacer()
                        }
                        .foregroundColor(.black)
                    } action: {
                        if receipt.isStart{
                            return await startAction()
                        }else if(receipt.isArrived || vm.startToWorkSucces?.success ?? false){
                            return await arrivedAction()
                        }else{
                            return pickUpAction()
                        }
                    }
                    .padding(.horizontal, 15)
                    .padding(.bottom,7)
                }
            }
        }
    }
    func actionButtonText() -> String {
        if receipt.isStart || vm.startToWorkSucces?.success ?? false {
            return tab == infoTabs[0] ? "Начать" : "Открыть в навигаторе"
        }else if(receipt.isArrived || vm.startToWorkSucces?.success ?? false){
            return "Я приехал"
        }else if(vm.arrivedDataSucces?.success ?? false){
            return receipt.isPickUp ? "Принимаю груз" : "Выдаю груз"
        }else{
            return receipt.isPickUp ? "Принимаю груз" : "Выдаю груз"
        }
    }
    @available(iOS 17.0, *)
    private func startAction() async -> TaskStatus{
        @ObservedObject var locationsHandler = LocationsHandler.shared
        
        let geo = GeoModel(lat:locationsHandler.lastLocation.coordinate.latitude, lng: locationsHandler.lastLocation.coordinate.longitude)
        if await vm.startToWork(id: receipt.id,geo: geo)?.success ?? false {
            return .success
        }else{
            return .faild(vm.startToWorkSucces?.message ?? "fix")
        }
    }
    
    private func arrivedAction() async -> TaskStatus{
        if await vm.arrivedToAddress(id: receipt.id)?.success ?? false {
            return .success
        }else{
            return .faild(vm.arrivedDataSucces?.message ?? "fix")
        }
    }
    private func pickUpAction() -> TaskStatus{
        NavigationStack {
            NavigationLink("Tap me") {
                Text("Destination")
            }
        }
        print(receipt.id)
        return .success
    }
}



struct TabDetailItem: View {
    let receipt: Receipt
    let isDone: Bool
    let tab: String
    var body: some View {
        switch tab {
        case "Информация":
            InfoDeliverWidget(isDone: isDone,receipt: receipt)
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
