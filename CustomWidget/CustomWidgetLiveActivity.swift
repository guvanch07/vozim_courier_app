//
//  CustomWidgetLiveActivity.swift
//  CustomWidget
//
//  Created by Guvanch Amanov on 15.11.23.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct CustomWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct CustomWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: CustomWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension CustomWidgetAttributes {
    fileprivate static var preview: CustomWidgetAttributes {
        CustomWidgetAttributes(name: "World")
    }
}

extension CustomWidgetAttributes.ContentState {
    fileprivate static var smiley: CustomWidgetAttributes.ContentState {
        CustomWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: CustomWidgetAttributes.ContentState {
         CustomWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: CustomWidgetAttributes.preview) {
   CustomWidgetLiveActivity()
} contentStates: {
    CustomWidgetAttributes.ContentState.smiley
    CustomWidgetAttributes.ContentState.starEyes
}
