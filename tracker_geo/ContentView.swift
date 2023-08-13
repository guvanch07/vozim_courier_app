//
//  ContentView.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 19.07.23.
//

import SwiftUI



struct ContentView: View {
    
    @EnvironmentObject var vm: LoginViewModel
    
    let localToken = UserDefaults.standard.string(forKey: "token")
    
    var body: some View {
        if localToken != nil || vm.isLoggedIn {
            HomeScreen()
        }else{
            LoginScreen()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


