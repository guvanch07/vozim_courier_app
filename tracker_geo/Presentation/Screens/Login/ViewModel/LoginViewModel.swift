//
//  LoginViewModel.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 6.08.23.
//

import Foundation
import Combine
import os

@MainActor
final class LoginViewModel: ObservableObject{
    
        @Published var loginData: LoginResponse?
        @Published private(set) var isRefreshing = false
        @Published var hasError = false
        @Published  var error: UserError?
        @Published var isLoggedIn = false
    let logger = Logger(subsystem: "com.apple.tracker_geo", category: "Login")
    
    private var loginUseCase = LoginUseCase(
        repository: RepositoryImpl(apiService: ApiService())
        )

    func login(phone:String,password:String) {
        logger.log("\(phone)")
        logger.log("\(password)")
        Task{
            DispatchQueue.main.async{
                self.isRefreshing = true
            }
            do {
                
                let data = LoginRequest(phone: phone, password: password)
                let usecase = try await loginUseCase.execute(loginRequest: data)
                UserDefaults.standard.set(usecase.token, forKey: "token")
                DispatchQueue.main.async{
                    self.loginData = usecase
                    self.isRefreshing = false
                    self.isLoggedIn = true
                }
            }catch{
                if let userErr = error as? UserError{
                    DispatchQueue.main.async{
                        self.hasError = true
                        self.error = userErr
                        self.isRefreshing = false
                    }
                }
            }
        }
    }
}
