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
    
    @StateObject private var vm = CurrentRoutesViewModel()
   
    
    var body: some View {
        if vm.startToWorkData != nil || isStarted {
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
            Button(
                action: {
                    print(UserDefaults.standard.string(forKey: "token") ?? "")
                    
                }, label: {
                    if vm.isRefreshingStart{
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
                Task{
                    await vm.startToWork(id: id)
                }
            }
        }
    }
}


