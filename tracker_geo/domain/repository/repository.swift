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
    func getCurrentRoutes() async throws -> CurrentResponseModel
}
