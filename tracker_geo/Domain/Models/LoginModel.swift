//
//  LoginModel.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 23.07.23.
//

import Foundation


struct LoginResponse:Decodable{
        let success: Bool
        let token: String
        let fio: String?
        let userId: String?
        let message: String?
}

struct LoginRequest:Decodable{
        let phone: String
        let password: String
}

extension LoginRequest{
    func toJson() -> Data?{
        let json: [String: Any?] =  ["phone":self.phone,
                                     "password": self.password
        ]
        
        return try? JSONSerialization.data(withJSONObject: json)
    }
}
