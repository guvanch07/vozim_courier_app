//
//  StartToWorkUseCase.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 24.08.23.
//

import Foundation


class StartToWorkUseCase {
    private let repository: IRepository
    
    init() {
        repository = RepositoryImpl(apiService: ApiService())
    }

    func execute(startToWorkRequest: RouteWorkRequest) async throws -> SuccesResponse {
        return try await repository.startToWork(startToWork: startToWorkRequest)
    }
}
