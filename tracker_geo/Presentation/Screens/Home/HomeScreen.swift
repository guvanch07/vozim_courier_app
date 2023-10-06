//
//  HomeScreen.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 4.08.23.
//

import SwiftUI

struct HomeScreen: View {
    @StateObject private var vm = LoginViewModel()
    var body: some View {
        
        TabView {
            DashboardScreen()
            VStack{
                Button{
                    vm.logOut()
                }label: {
                    Text("remove token")
                }
                Text("Search")
            }.tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            if #available(iOS 17.0, *){
                ProfileView().tabItem {
                    Label("Notification", systemImage: "bell")
                }
            }else{
                EmptyView().tabItem {
                    Label("Notification", systemImage: "bell")
                }
            }
        }
        
    }
    
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
