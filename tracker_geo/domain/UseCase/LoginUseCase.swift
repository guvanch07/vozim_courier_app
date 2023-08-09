//
//  LoginUseCase.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 6.08.23.
//

import Foundation

class LoginUseCase {
    let repository: IRepository
    
    init(repository: IRepository) {
        self.repository = repository
    }
    
    func execute(loginRequest: LoginRequest) async throws -> LoginResponse {
         return try await repository.login(loginRequest: loginRequest)
    }
}
