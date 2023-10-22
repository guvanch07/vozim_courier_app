//
//  StartT0WorkButton.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 23.08.23.
//

import SwiftUI

struct StartT0WorkButton: View {
    let id: String
    let receipt:Receipt
    
    @StateObject private var vm = DetailViewModel()
    @State private var isPresented = false
   
    
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
                .disabled(false)
                .padding(.vertical, 7)
                .padding(.horizontal, 50)
                .foregroundColor(.black)
                .background(appAccentColor)
                .cornerRadius(24)
                .onTapGesture {
                    print(UserDefaults.standard.string(forKey: "token") ?? "")
                    Task{
                       let response  = await vm.startToWork(id: id)
                        if response != nil {
                            isPresented = true
                        }
                    }
                }.navigationDestination(isPresented: $isPresented) {
                    DeliveryDetailScreen(receipt: receipt, id: receipt.id)
                }
            }
        }
}


