//
//  RefuseUseCase.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 24.11.23.
//

import Foundation

class RefuseCargoUseCase {
    private let repository: IRepository
    
    init() {
        repository = RepositoryImpl(apiService: ApiService())
    }

    func execute(request: RefuseDataRequest) async throws -> SuccesResponse {
        return try await repository.refuseCargo(request: request)
    }
}
