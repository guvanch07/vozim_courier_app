//
//  repository_impl.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 23.07.23.
//

import Foundation

final class RepositoryImpl: IRepository{
    
    let apiService: ApiService
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    func login(loginRequest: LoginRequest) async throws -> LoginResponse {
        let request = try await apiService.post(
            endPoint: "\(baseUrl)courier/login",
            data: loginRequest.toJson(),
            type: LoginResponse.self)
        return request
    }
    
    func getPlacholderList() async throws -> [PostModel] {
        let request = try await apiService.get(endPoint: "https://jsonplaceholder.typicode.com/posts",type: [PostModel].self)
        return request
    }
    
    func getCurrentRoutes(tab:Int) async throws -> CurrentResponseModel {
        let response = try await apiService.get(
            endPoint: "\(baseUrl)courier/currentRoute?tab=\(tab)",
            type: CurrentResponseModel.self)
        return response
    }
    func startToWork(startToWork: RouteWorkRequest) async throws -> SuccesResponse {
        let response = try await apiService.post(
            endPoint: "\(baseUrl)courier/start",
            data: startToWork.toJson(),
            type: SuccesResponse.self
        )
        print(response)
        return response
    }
    
    func arriveToAddress(arrive: RouteWorkRequest) async throws -> SuccesResponse {
        let response = try await apiService.post(
            endPoint: "\(baseUrl)courier/arrived",
            data: arrive.toJson(),
            type: SuccesResponse.self
        )
        print(response)
        return response
    }
    func geoTrack(geo: GeoTrackRequest) async throws -> SuccesResponse{
        let response = try await apiService.post(
            endPoint: "\(baseUrl)courier/trackGeo",
            data: geo.toJson(),
            type: SuccesResponse.self
        )
        return response
    }
    
    func getAllCargo() async throws -> AllCargoResponse {
        let response = try await apiService.get(
            endPoint: "\(baseUrl)courier/bodyCargos",
            type: AllCargoResponse.self
        )
        return response
    }
    
    func refuseCargo(request: RefuseDataRequest) async throws -> SuccesResponse {
        print(try request.toJson())
        let response = try await apiService.post(
            endPoint: "\(baseUrl)courier/refuse",
            data: request.toJson(),
            type: SuccesResponse.self
        )
        return response
    }
}
