//
//  ArrivedToAddress.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 8.10.23.
//

import Foundation

class ArrivedToAddressUseCase {
    private let repository: IRepository
    
    init() {
        repository = RepositoryImpl(apiService: ApiService())
    }

    func execute(arrivedRequest: RouteWorkRequest) async throws -> SuccesResponse {
        return try await repository.arriveToAddress(arrive: arrivedRequest)
    }
}
