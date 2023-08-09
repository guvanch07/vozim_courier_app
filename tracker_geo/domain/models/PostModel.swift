//
//  PostModel.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 23.07.23.
//

import Foundation



struct PostModel:Decodable{
        let userId: Int
        let id: Int?
        let title: String?
        let body: String?
    
}

struct PostResponse : Decodable {
    let results: [PostModel]
}


extension PostModel{
    func toJson() -> Data?{
        let json: [String: Any?] =  ["title":self.title,
                                     "body": self.body,
                                     "userId": self.userId]
        return try? JSONSerialization.data(withJSONObject: json)
    }
}
