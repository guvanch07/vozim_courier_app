//
//  AllCargoResponse.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 9.10.23.
//

import Foundation

struct AllCargoResponse: Decodable{
    let receipts: [Receipt]
}
