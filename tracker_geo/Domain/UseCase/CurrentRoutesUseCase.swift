//
//  CurrentRoutesUseCase.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 8.08.23.
//

import Foundation


class CurrentRoutesUseCase {
    private let repository: IRepository
    
    init() {
        repository = RepositoryImpl(apiService: ApiService())
    }
    
    func execute(tab:Int) async throws -> CurrentResponseModel {
        try await repository.getCurrentRoutes(tab:tab)
    }
}
