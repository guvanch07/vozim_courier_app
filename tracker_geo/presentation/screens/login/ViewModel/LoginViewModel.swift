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
