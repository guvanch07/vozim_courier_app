//
//  GetAllCargoUseCase.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 9.10.23.
//

import Foundation

class GetAllCargoUseCase {
    private let repository: IRepository
    
    init() {
        repository = RepositoryImpl(apiService: ApiService())
    }

    func execute() async throws -> AllCargoResponse {
        return try await repository.getAllCargo()
    }
}
