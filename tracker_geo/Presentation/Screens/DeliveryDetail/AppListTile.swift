//
//  AppListTile.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 13.08.23.
//

import SwiftUI

struct AppListTile: View {
    let image:String
    let title:String
    var subtitle:String?
    var view: AnyView?
    var replace: Bool = false
    var size: (Double,Double) = (24,24)
    var body: some View {
        HStack{
            Image(image)
                .resizable()
                .frame(width: size.0,height: size.1)
            Spacer().frame(width: 16)
            VStack(
                alignment: .leading
            ){
                Text(title)
                    .font(.system(size: replace ? 13 : 14.5))
                    .foregroundStyle(replace ? .gray : .black)
                    .fontWeight( replace ? .light :.medium)
                if subtitle != nil {
                    Text(subtitle!)
                        .font(.system(size: replace ? 14.5 : 13))
                        .foregroundStyle(replace ? .black : .gray)
                        .fontWeight( replace ? .medium :.light)
                        .padding([.top],1)
                }
            }
            Spacer().frame(width: 16)
            if view != nil  {
                view
            }
            
        }
    }
}

