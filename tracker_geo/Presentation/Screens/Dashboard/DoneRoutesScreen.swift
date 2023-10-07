//
//  DoneRoutesListScreen.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 7.10.23.
//

import SwiftUI

struct DoneRoutesScreen: View {
    @StateObject private var vm = CurrentRoutesViewModel()
    var body: some View {
        VStack{
            if vm.isRefreshing {
                Spacer()
                ProgressView()
                Spacer()
            }else{
                if vm.listReceipts.isEmpty{
                    Spacer()
                    Text("NO ROUTES")
                    Spacer()
                }else{
                    List(vm.listReceipts,id: \.id) {
                        DeliveryItem(data: $0, isFirst: false)
                            .id($0.id)
                            .padding(.vertical,8)
                    }
                }
            }
        }.task{
            await vm.getCurrentRoutes(tab: 1)
        }.alert(isPresented: $vm.hasError, error: vm.error) {
            Button{
                Task{
                    //await vm.getCurrentRoutes()
                }
            }label: {
                Text("OK")
            }
        }
    }
}


#Preview {
    DoneRoutesScreen()
}
