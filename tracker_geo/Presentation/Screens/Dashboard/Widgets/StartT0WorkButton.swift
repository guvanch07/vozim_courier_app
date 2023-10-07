//
//  StartT0WorkButton.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 23.08.23.
//

import SwiftUI

struct StartT0WorkButton: View {
    let isStarted: Bool
    let id: String
    let receipt:Receipt
    
    @StateObject private var vm = DetailViewModel()
    @State private var isPresented = false
   
    
    var body: some View {
        if  isStarted {
            Button(
                action: {
                    print(UserDefaults.standard.string(forKey: "token") ?? "")
                }, label: {
                    HStack(spacing: 5){
                        Text("Открыть в навигаторе")
                            .foregroundStyle(appAccentColor)
                        Image(systemName: "arrow.right")
                            .foregroundColor(appAccentColor)
                    }.padding(.horizontal,20)
                        .padding(.vertical,7)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(appAccentColor, lineWidth: 1)
                        )
                }
            )
            .onTapGesture {
                print(UserDefaults.standard.string(forKey: "token") ?? "")
            }
        }else{
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
}


