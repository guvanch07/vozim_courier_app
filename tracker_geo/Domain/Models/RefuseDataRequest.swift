//
//  RefuseDataRequest.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 24.11.23.
//


import Foundation

struct RefuseDataRequest: Codable {
    let receipt: String
    let reason: String
    let ourFault: Bool
    let expenses: Expenses
    let geo: Geo

    enum CodingKeys: String, CodingKey {
        case receipt
        case reason
        case ourFault = "our_fault"
        case expenses
        case geo
    }

    func toJson() throws -> Data {
        return try JSONEncoder().encode(self)
    }
}

struct Expenses: Codable {
    let paidEntry: Int
    let unexpected: Int

    enum CodingKeys: String, CodingKey {
        case paidEntry = "paid_entry"
        case unexpected
    }
}



//import Foundation
//
//struct RefuseDataRequest: Decodable {
//    let receipt: String
//    let reason:String
//    let ourFault: Bool
//    let expenses: Expenses
//    let geo: Geo
//}
//
//extension RefuseDataRequest{
//    func toJson() -> Data?{
//        let json: [String: Any?] =  ["receipt":self.receipt,
//                                     "reason": self.reason,
//                                     "our_fault":self.ourFault,
//                                     "expenses":[
//                                        "paid_entry": self.expenses.paidEntry,
//                                        "unexpected": self.expenses.unexpected
//                                     ],
//                                     "geo": [
//                                        "lat":self.geo.lat,
//                                        "lng":self.geo.lng
//                                     ]
//        ]
//        
//        return try? JSONSerialization.data(withJSONObject: json)
//    }
//}
//
//struct Expenses: Decodable{
//    let paidEntry: Int
//    let unexpected: Int
//}
