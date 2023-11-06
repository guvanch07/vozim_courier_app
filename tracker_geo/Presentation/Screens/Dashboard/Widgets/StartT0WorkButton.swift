//
//  StartT0WorkButton.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 23.08.23.
//

import SwiftUI

@available(iOS 17.0, *)
struct StartT0WorkButton: View {
    let id: String
    let receipt:Receipt
    @StateObject private var vm = DetailViewModel()
    @State private var isPresented = false
    @ObservedObject var locationsHandler = LocationsHandler.shared
    var body: some View {
        NavigationStack(){
            Button(
                action: {
                    print(UserDefaults.standard.string(forKey: "token") ?? "")
                }, label: {
                    if vm.isLoading{
                        ProgressView()
                    }else{
                        Text("Начать")
                    }
                }
            )
            .disabled(vm.isLoading)
            .padding(.vertical, 7)
            .padding(.horizontal, 50)
            .foregroundColor(.black)
            .background(appAccentColor)
            .cornerRadius(24)
            .onTapGesture {
                Task{
                    self.locationsHandler.startLocationUpdates()
                    self.locationsHandler.backgroundActivity.toggle()
                    
                    let geo = GeoModel(lat: self.locationsHandler.lastLocation.coordinate.latitude, lng: self.locationsHandler.lastLocation.coordinate.longitude)
                    let response  = await vm.startToWork(id: id,geo: geo)
                    if response?.success != nil {
                        isPresented = true
                    }
                }
            }.navigationDestination(isPresented: $isPresented) {
                DeliveryDetailScreen(receipt: receipt, id: receipt.id, isDone: false)
            }
        }
    }
}


