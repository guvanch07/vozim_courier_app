//
//  LoginButton.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 13.08.23.
//

import SwiftUI

struct LoginButton: View {
   
    let phone : String
    let passwordField: String
    
    @StateObject private var vm = LoginViewModel()
    var body: some View {
            Button {
                vm.login(phone: phone, password: passwordField)
                hideKeyboard()
               
            } label: {
                HStack{
                    Spacer()
                    if vm.isRefreshing{
                        ProgressView()
                    }else{
                        Text("Начать")
                    }
                    Spacer()
                }
            }
            .disabled(vm.isRefreshing)
            .padding([.vertical], 10)
            .foregroundColor(.black)
            .background(appAccentColor)
            .cornerRadius(24)

    }
}

