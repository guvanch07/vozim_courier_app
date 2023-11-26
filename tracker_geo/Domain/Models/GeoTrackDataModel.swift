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
    
    enum CodingKeys: String, CodingKey {
        case event
        case id
        case geo
    }
    
    func toJson() throws -> Data {
        return try JSONEncoder().encode(self)
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

    enum CodingKeys: String, CodingKey {
        case id
        case lat
        case lng
//        case acu
//        case spd
//        case acs
//        case hdn
//        case ach
//        case alt
//        case aca
//        case act
//        case note
//        case flr
    }
}
