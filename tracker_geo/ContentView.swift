//
//  ContentView.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 19.07.23.
//

import SwiftUI



struct ContentView: View {
    let request = RepositoryImpl(apiService: ApiService())

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            
            AppImagePickerUIView()
            Button("Get")  {
                
                Task {
                    do{
                        let data = try await request.getPlacholderList()
                        print(data)
                    }catch{
                        print("something wrong")
                    }
                }
                
            }.padding()
            
            Button("Post")  {
                Task{
                    do{
                        let req = LoginRequest(phone: "+375(00)123-00-10", password: "test")
                        let data = try await request.login(loginRequest: req)
                        print(data)
                    }catch{
                        print("smth wrong")
                    }
                }
            }.padding()
            
        }
        .padding()
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


