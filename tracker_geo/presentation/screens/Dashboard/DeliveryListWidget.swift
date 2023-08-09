//
//  DeliveryListWidget.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 4.08.23.
//

import SwiftUI

struct DeliveryListWidget: View {
    @StateObject private var vm = CurrentRoutesViewModel()
    var body: some View {
        VStack{
            if vm.isRefreshing {
                Spacer()
                ProgressView()
                Spacer()
            }else{
                if vm.listReceipts.isEmpty{
                    Text("NO ROUTES")
                }else{
                    List {
                        ForEach(vm.listReceipts,id: \.id) { i in
                            NavigationLink {
                                DeliveryDetailScreen(id: i.id, title: i.address.street)
                            } label: {
                                DeliveryItem(data: i, isFirst: false)
                                    .id(i.id)
                            }
                        }
                    }
                }
            }
        }.task{
            await vm.getCurrentRoutes()
        }.alert(isPresented: $vm.hasError, error: vm.error) {
            Button{
                Task{
                    //await vm.getCurrentRoutes()
                }
            }label: {
                Text("Retry")
            }
        }
    }
}

struct DeliveryListWidget_Previews: PreviewProvider {
    static var previews: some View {
        DeliveryListWidget()
    }
}
