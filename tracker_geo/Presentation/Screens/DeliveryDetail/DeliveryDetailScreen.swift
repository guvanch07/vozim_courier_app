//
//  DeliveryDetailScreen.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 6.08.23.
//

import SwiftUI

struct DeliveryDetailScreen: View {
    
    let receipt: Receipt
    let id:String

    var body: some View {
      
        MainDetailWidget(receipt: receipt)
            .background(Color(uiColor: .systemGroupedBackground))
            .controlSize(.large)
            .navigationTitle(receipt.address.street)
            .navigationBarTitleDisplayMode(.inline)
           
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: "info.circle")
                        .onTapGesture {
                            print("\(receipt.id)")
                        }
                }
            }
    }
}



