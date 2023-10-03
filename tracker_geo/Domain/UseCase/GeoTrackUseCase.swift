//
//  GeoTrackUseCase.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 3.10.23.
//

import Foundation

struct GeoTrackUseCase {
    private let repository: IRepository
    
    init() {
        repository = RepositoryImpl(apiService: ApiService())
    }

    func execute(request: GeoTrackRequest) async throws -> SuccesResponse {
        return try await repository.geoTrack(geo: request)
    }
}
