//
//  CurrentRoutesUseCase.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 8.08.23.
//

import Foundation


class CurrentRoutesUseCase {
    let repository: IRepository
    
    init(repository: IRepository) {
        self.repository = repository
    }
    
    func execute() async throws -> CurrentResponseModel {
          try await repository.getCurrentRoutes()
    }
}
