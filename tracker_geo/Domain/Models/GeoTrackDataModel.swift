//
//  GeoTrackDataModel.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 3.10.23.
//

import Foundation

struct GeoTrackRequest: Codable {
    let event: String
    let id: String
    let geo: Geo
}

extension GeoTrackRequest {
    func toJson() -> Data? {
        let encoder = JSONEncoder()
        return try? encoder.encode(self)
    }
}

struct Geo: Codable {
    let id: Int?
    let lat: Double?
    let lng: Double?
    let acu: Double?
    let spd: Double?
    let acs: Double?
    let hdn: Double?
    let ach: Double?
    let alt: Double?
    let aca: Double?
    let act: Double?
}


//struct GeoTrackRequest: Decodable {
//    let event: String
//    let id: String
//    let geo: Geo
//}
//
//extension GeoTrackRequest{
//    func toJson() -> Data?{
//        let json: [String: Any?] =  ["event":self.event,
//                                     "id":self.id,
//                                     "geo": [
//                                        "lat":self.geo.lat ?? 0,
//                                        "lng":self.geo.lng ?? 0,
//                                        "id": self.geo.id ?? 0,
//                                        "acu": self.geo.acu ?? 0,
//                                        "spd": self.geo.spd ?? 0,
//                                        "acs": self.geo.acs ?? 0,
//                                        "hdn": self.geo.hdn ?? 0,
//                                        "ach": self.geo.ach ?? 0,
//                                        "alt": self.geo.alt ?? 0,
//                                        "aca": self.geo.aca ?? 0,
//                                        "act": self.geo.act ?? 0,
//                                     ]
//        ]
//        return try? JSONSerialization.data(withJSONObject: json)
//    }
//}
//
//struct Geo: Decodable{
//    let id: Int?
//    let lat: Double?
//    let lng: Double?
//    let acu: Double?
//    let spd: Double?
//    let acs: Double?
//    let hdn: Double?
//    let ach: Double?
//    let alt: Double?
//    let aca: Double?
//    let act: Double?
//}
