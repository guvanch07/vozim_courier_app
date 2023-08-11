//
//  Place.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 11.08.23.
//

import Foundation

import SwiftUI
import MapKit

struct Place: Identifiable {
    var id = UUID().uuidString
    var placemark: CLPlacemark
    
}
