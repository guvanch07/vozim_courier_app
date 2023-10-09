//
//  MainDetailWidget.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 13.08.23.
//

import SwiftUI

struct MainDetailWidget: View {
    let receipt: Receipt
    @State private var tab = "Информация"
    @StateObject private var vm = DetailViewModel()
    var colors = ["Информация", "Карта"]
    var body: some View {
        VStack{
            if vm.startToWorkSucces?.success ?? false{
                EventTile(title: "Бесплатное ожидание 14:59")
            }
            Picker("Where", selection: $tab) {
                ForEach(colors, id: \.self) {
                    Text($0)
                }
            }.pickerStyle(.segmented)
                .padding([.top,.trailing,.leading],15)
                .background(Color(uiColor: .systemGroupedBackground))
                .controlSize(.large)
            TabDetailItem(receipt: receipt, tab: tab)
            if #available(iOS 17.0, *) {
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
    func actionButtonText() -> String {
        if receipt.isStart || vm.startToWorkSucces?.success ?? false {
            return tab == colors[0] ? "Начать" : "Открыть в навигаторе"
        }else if(receipt.isArrived || vm.startToWorkSucces?.success ?? false){
            return "Я приехал"
        }else if(vm.arrivedDataSucces?.success ?? false){
            return receipt.isPickUp ? "Принимаю груз" : "Выдаю груз"
        }else{
            return receipt.isPickUp ? "Принимаю груз" : "Выдаю груз"
        }
    }
    private func startAction() async -> TaskStatus{
        if await vm.startToWork(id: receipt.id)?.success ?? false {
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
        return .success
    }
}



struct TabDetailItem: View {
    let receipt: Receipt
    let tab: String
    var body: some View {
        switch tab {
        case "Информация":
            InfoDeliverWidget(receipt: receipt)
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
