//
//  CustomWidgetBundle.swift
//  CustomWidget
//
//  Created by Guvanch Amanov on 15.11.23.
//

import WidgetKit
import SwiftUI

@main
struct CustomWidgetBundle: WidgetBundle {
    var body: some Widget {
        CustomWidget()
        CustomWidgetLiveActivity()
    }
}
