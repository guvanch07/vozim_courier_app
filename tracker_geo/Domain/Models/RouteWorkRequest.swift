//
//  StartToWorkRequest.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 24.08.23.
//

import Foundation

struct RouteWorkRequest: Codable {
    let receipt: String
    let geo: GeoModel
}

extension RouteWorkRequest{
    func toJson() -> Data?{
        let json: [String: Any?] =  ["receipt":self.receipt,
                                     "geo": [
                                        "lat":self.geo.lat,
                                        "lng":self.geo.lng
                                     ]
        ]
        
        return try? JSONSerialization.data(withJSONObject: json)
    }
}

struct GeoModel: Codable{
    let lat: Double
    let lng:Double
}
