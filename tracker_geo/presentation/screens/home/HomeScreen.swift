//
//  HomeScreen.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 4.08.23.
//

import SwiftUI

struct HomeScreen: View {
   
    var body: some View {
        
        TabView {
            DashboardScreen()
           
            VStack{
                Button{
                    print(UserDefaults.standard.removeObject(forKey: "token"))
                }label: {
                    Text("token")
                }
                Text("Search")
            }.tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                    
                }
            Text("Notification")
                .tabItem {
                    
                    Label("Notification", systemImage: "bell")
                }
            
        }
        
    }
    
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
