//
//  AllCargosScreen.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 9.10.23.
//

import SwiftUI

struct AllCargosScreen: View {
    @StateObject private var vm = GetAllCargoViewModel()
    var body: some View {
        VStack{
            if vm.isRefreshing {
                Spacer()
                ProgressView()
                Spacer()
            }else{
                if vm.listCargos.isEmpty{
                    Spacer()
                    Text("NO ROUTES")
                    Spacer()
                }else{
                    List(Array(vm.listCargos.enumerated()), id: \.offset) { index, element in
                        DeliveryItem(data: element, isFirst: false)
                            .id(element.id)
                            .padding(.vertical,8)
                    }
                }
            }
        }.task{
            await vm.getAllCargos()
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
    AllCargosScreen()
}
