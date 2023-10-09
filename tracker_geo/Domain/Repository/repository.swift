//
//  repository.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 23.07.23.
//

import Foundation

protocol IRepository {
    func getPlacholderList() async throws -> [PostModel]
    func login(loginRequest: LoginRequest) async throws -> LoginResponse
    func getCurrentRoutes(tab: Int) async throws -> CurrentResponseModel
    func startToWork(startToWork: RouteWorkRequest) async throws -> SuccesResponse
    func arriveToAddress(arrive: RouteWorkRequest) async throws -> SuccesResponse
    func geoTrack(geo: GeoTrackRequest) async throws -> SuccesResponse
    func getAllCargo() async throws -> AllCargoResponse
}
