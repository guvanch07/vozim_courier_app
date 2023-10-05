//
//  api_impl.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 23.07.23.
//

import Foundation
import os



class ApiService{
    
    let token = UserDefaults.standard.string(forKey: "token")
    let logger = Logger(subsystem: "com.apple.tracker_geo", category: "Api_Impl")
    
    func get<T:Decodable>(endPoint:String, type: T.Type) async throws -> T {
        
        guard let url = URL(string: endPoint) else {
            print("error in url")
            throw UserError.badUrl
            }
        var request = URLRequest(url: url)
        
        if token != nil {
            request.setValue(token!, forHTTPHeaderField: "Authorization")
        }
        request.httpMethod = "GET"
        let (data,response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            
            switch (response as? HTTPURLResponse)?.statusCode {
            case 400:
                throw UserError.badUrl
            case 401:
                throw UserError.noAuth
            case 403:
                throw UserError.badRequest
            case 404:
                throw UserError.noData
            case 500:
                throw UserError.badUrl
            default:
                throw UserError.noInternet
            }
        }
        do{
            let decoder = JSONDecoder()
            //decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decoded = try decoder.decode(T.self, from: data)
            print(decoded)
            return decoded
        }catch{
            throw UserError.noData
        }
    }
    
    func post<T:Decodable>(endPoint:String,data:Data?,type: T.Type) async throws -> T {
        
        guard let url = URL(string: endPoint) else {
            print("error in url")
            throw UserError.badUrl
        }
        do{
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = data
            if token != nil {
                request.setValue(token, forHTTPHeaderField: "Authorization")
            }
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
            let (data, response) = try await URLSession.shared.data(for: request)
            logger.info("\(data)")
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                switch (response as? HTTPURLResponse)?.statusCode {
                case 400:
                    throw UserError.badUrl
                case 401:
                    throw UserError.noAuth
                case 403:
                    throw UserError.badRequest
                case 404:
                    throw UserError.noData
                case 500:
                    throw UserError.badUrl
                default:
                    throw UserError.noInternet
                }
            }
            let answer = try JSONDecoder().decode(T.self, from: data)
            return answer
        }catch{
            throw UserError.noData
        }
    }

}
