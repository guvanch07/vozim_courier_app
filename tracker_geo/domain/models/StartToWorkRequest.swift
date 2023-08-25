//
//  StartToWorkRequest.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 24.08.23.
//

import Foundation

struct StartToWorkRequest: Decodable {
    let receipt: String
    let geo: GeoModel
}

extension StartToWorkRequest{
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

struct GeoModel: Decodable{
    let lat: Double
    let lng:Double
}
