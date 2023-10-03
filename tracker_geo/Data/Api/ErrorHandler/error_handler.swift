//
//  error_handler.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 23.07.23.
//

import Foundation


enum UserError: LocalizedError{
    case custom(error:Error)
    case badUrl
    case noAuth
    case noData
    case serverInternal
    case badRequest
    case noInternet
    
    var errorDescription: String?{
        switch self {
        case .badUrl:
            return "Bad Request"
        case .badRequest:
            return "No valid request"
        case .custom(let error):
            return error.localizedDescription
        case .noData:
            return "Not Found"
        case .noAuth:
            return "Fail with authorization"
        case .serverInternal:
            return "Fail server"
        case .noInternet:
            return "No Internet"
        }
    }
}
