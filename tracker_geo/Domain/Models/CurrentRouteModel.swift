//
//  CurrentRouteModel.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 8.08.23.
//

import Foundation

// MARK: - CurrentResponseModel
struct CurrentResponseModel: Decodable {
    let id, number, date: String
    let isOpen: Bool
    let confirmations: Confirmations
    let logist: Logist
    let app: AppVersion
    let receipts: [Receipt]
    let needStockPickupCount: Int
    let stats: Stats

    enum CodingKeys: String, CodingKey {
        case id, number, date
        case isOpen = "is_open"
        case confirmations, logist, app, receipts
        case needStockPickupCount = "need_stock_pickup_count"
        case stats
    }
}

// MARK: - App
struct AppVersion: Decodable {
    let androidVersion, iosVersion: String

    enum CodingKeys: String, CodingKey {
        case androidVersion = "android_version"
        case iosVersion = "ios_version"
    }
}

// MARK: - Confirmations
struct Confirmations: Decodable {
    let start, confirmationsReturn, refuse, reception: Bool

    enum CodingKeys: String, CodingKey {
        case start
        case confirmationsReturn = "return"
        case refuse, reception
    }
}

// MARK: - Logist
struct Logist: Decodable {
    let name, phone: String
}

// MARK: - Receipt
struct Receipt: Decodable {
    let id, series, number, goodName: String
    let additional: String
    let goodCount, pointType, status, reaction: Int
    let arrivedTimestamp: Int
    let reweight, ready: Bool
    let cityDelivery: CityDelivery
    let needStockPickup, fragile: Bool
    let sizes: [Size]
    let client: Client
    let receiver, sender: Receiver
    let manager: Logist
    let currency: String
    let payment: Int
    let deliveryTime: DeliveryTime
    let address: Address
    let services: Services
    let note: String

    enum CodingKeys: String, CodingKey {
        case id, series, number
        case goodName = "good_name"
        case additional
        case goodCount = "good_count"
        case pointType = "point_type"
        case status, reaction
        case arrivedTimestamp = "arrived_timestamp"
        case reweight, ready
        case cityDelivery = "city_delivery"
        case needStockPickup = "need_stock_pickup"
        case fragile, sizes, client, receiver, sender, manager, currency, payment
        case deliveryTime = "delivery_time"
        case address, services, note
    }
    var isStock: Bool {
        get{return  pointType == 3 }
    }
    var isDelivery: Bool {
        get{return pointType == 2}
    }
    var isPickUp: Bool {
        get{return pointType == 1}
    }
    var onlyDelivery: Bool {
        get{return pointType != 3 && pointType != 1}
    }
}

// MARK: - Address
struct Address: Decodable {
    let street: String
    let lat, lng: Double
}

// MARK: - CityDelivery
struct CityDelivery: Decodable {
    let receiveID, deliveryID: String

    enum CodingKeys: String, CodingKey {
        case receiveID = "receive_id"
        case deliveryID = "delivery_id"
    }
}

// MARK: - Client
struct Client: Decodable {
    let name: String
    let isCompany: Bool
    let phone: String

    enum CodingKeys: String, CodingKey {
        case name
        case isCompany = "is_company"
        case phone
    }
}

// MARK: - DeliveryTime
struct DeliveryTime: Decodable {
    let from, to: String
}

// MARK: - Receiver
struct Receiver: Decodable {
    let name, companyName, phone, additional: String
    let address: Address
    let timeFrom, timeTo: String
   

    enum CodingKeys: String, CodingKey {
        case name
        case companyName = "company_name"
        case phone, additional, address
        case timeFrom = "time_from"
        case timeTo = "time_to"
       
    }
}

// MARK: - Services
struct Services: Decodable {
    let before18, driverHelp: Before18
    let loader: Loader

    enum CodingKeys: String, CodingKey {
        case before18 = "before_18"
        case driverHelp = "driver_help"
        case loader
    }
}

// MARK: - Before18
struct Before18: Decodable {
    let enabled: Bool
}

// MARK: - Loader
struct Loader: Decodable {
    let enabled: Bool
    let count: Int
}

// MARK: - Size
struct Size: Identifiable, Decodable {
    var id:UUID?
    let w, h, l, kg: Int
}

// MARK: - Stats
struct Stats: Decodable {
    let receiveCount, deliveryCount, km: Int
    let dateOpened: String

    enum CodingKeys: String, CodingKey {
        case receiveCount = "receive_count"
        case deliveryCount = "delivery_count"
        case km
        case dateOpened = "date_opened"
    }
}

