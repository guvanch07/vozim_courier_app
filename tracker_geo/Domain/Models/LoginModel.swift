//
//  LoginModel.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 23.07.23.
//

import Foundation


struct LoginResponse:Codable{
        let success: Bool
        let token: String
        let fio: String?
        let userId: String?
        let message: String?
}



struct LoginRequest:Codable{
        let phone: String
        let password: String
    
    enum CodingKeys: String, CodingKey {
        case phone
        case password
    }

    func toJson() throws -> Data {
        return try JSONEncoder().encode(self)
    }
}
