//
//  ProfileScreen.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 15.10.23.
//

import SwiftUI

struct ProfileScreen: View {
    @EnvironmentObject var vm: LoginViewModel
    @State private var isModalPresented = false
    var body: some View {
        VStack{
            Button{
                print("\(String(describing: UserDefaults.standard.string(forKey: "token")))")
            }label: {
                Text("show token")
            }
            Button{
                vm.logOut()
            }label: {
                Text("remove token")
            }
            Button("Present Modal") {
                isModalPresented = true
            }
            .sheet(isPresented: $isModalPresented) {
                EmptyView()
            }
            
        }.tabItem {
            Label("Профиль", systemImage: "person").labelStyle(.iconOnly)
        }
    }
}

#Preview {
    ProfileScreen()
}
