//
//  DeliveryDetailScreen.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 6.08.23.
//

import SwiftUI

struct DeliveryDetailScreen: View {
    let id:String
    let title:String
    var body: some View {
        Text(title)
    }
}

struct DeliveryDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        DeliveryDetailScreen(id: "", title: "test")
    }
}
