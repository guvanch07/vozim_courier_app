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
    
    func getCurrentRoutes() async throws -> CurrentResponseModel {
        let response = try await apiService.get(endPoint: "\(baseUrl)courier/currentRoute",type: CurrentResponseModel.self)
        
        return response
    }
    
    
    
    
}
