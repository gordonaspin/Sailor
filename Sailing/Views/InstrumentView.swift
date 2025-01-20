//
//  WidgetView.swift
//  Sailor
//
//  Created by Gordon Aspin on 1/18/25.
//

import SwiftUI

struct InstrumentView: View {
    var widgetText: String
    var color: Color
    var unitsText: String
    var unitsColor: Color
    var fontSize: CGFloat
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(widgetText)
                .font(.system(size: fontSize).monospacedDigit())
                .fontWidth(.compressed)
                .bold()
                .padding(.top, -40)
                .padding(.bottom, -40)
                .foregroundColor(color)
            if !unitsText.isEmpty {
                Text(unitsText)
                    .font(.body)
                    .foregroundColor(unitsColor)
                    .bold()
                    .padding(-16)
            }
        }
    }
}

#Preview {
    struct Preview: View {
        var body: some View {
            InstrumentView(widgetText: "122", color: Color.blue, unitsText: "KTS", unitsColor: Color.blue, fontSize: 200)
        }
    }
    return Preview()
}
