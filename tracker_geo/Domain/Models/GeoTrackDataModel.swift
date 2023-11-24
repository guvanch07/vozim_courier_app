//
//  GeoTrackDataModel.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 3.10.23.
//

import Foundation

//struct GeoTrackRequest: Codable {
//    let event: String
//    let id: String
//    let geo: Geo
//}
//
//extension GeoTrackRequest {
//    func toJson() -> Data? {
//        let encoder = JSONEncoder()
//        return try? encoder.encode(self)
//    }
//    //try? JSONSerialization.data(withJSONObject: json)
//}
//
//struct Geo: Codable {
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
//    let act: Int64?
//    let note: String?
//    let flr: Int?
//}


struct GeoTrackRequest: Codable {
    let event: String
    let id: String
    let geo: Geo
}

extension GeoTrackRequest{
    func toJson() -> Data?{
        let geoJson:[String:Any?] = [
            "id": self.geo.id,
            "lat":self.geo.lat,
            "lng":self.geo.lng,
            //            "acu": self.geo.acu,
            //            "spd": self.geo.spd,
            //            "acs": self.geo.acs,
            //            "hdn": self.geo.hdn,
            //            "ach": self.geo.ach,
            //            "alt": self.geo.alt,
            //            "aca": self.geo.aca,
            //            "act": self.geo.act,
            //            "note": self.geo.note,
            //            "flr": self.geo.flr,
        ]
        let json: [String: Any?] =  ["event":self.event,
                                     "id":self.id,
                                     "geo": geoJson
        ]
        return try? JSONSerialization.data(withJSONObject: json)
    }
}

struct Geo: Codable {
    let id: Int?
    let lat: Double?
    let lng: Double?
    //    let acu: Double?
    //    let spd: Double?
    //    let acs: Double?
    //    let hdn: Double?
    //    let ach: Double?
    //    let alt: Double?
    //    let aca: Double?
    //    let act: Int64?
    //    let note: String?
    //    let flr: Int?
}
