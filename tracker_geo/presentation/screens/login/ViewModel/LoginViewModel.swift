//
//  LoginViewModel.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 6.08.23.
//

import Foundation
import Combine

final class LoginViewModel: ObservableObject{
    
        @Published var loginData: LoginResponse?
        @Published private(set) var isRefreshing = false
        @Published var hasError = false
        @Published  var error: UserError?
    
    private var loginUseCase = LoginUseCase(
        repository: RepositoryImpl(apiService: ApiService())
        )

    func login(phone:String,password:String){
        Task{
            isRefreshing = true
            defer{isRefreshing = false}
            do {
                let data = LoginRequest(phone: phone, password: password)
                let usecase = try await loginUseCase.execute(loginRequest: data)
                UserDefaults.standard.set(usecase.token, forKey: "token")
                
                self.loginData = usecase
            }catch{
                if let userErr = error as? UserError{
                    self.hasError = true
                    self.error = userErr
                }
            }
        }
    }
}
