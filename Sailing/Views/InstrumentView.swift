//
//  WidgetView.swift
//  Sailor
//
//  Created by Gordon Aspin on 1/18/25.
//

import SwiftUI

struct InstrumentView: View {
    var instrumentName: String
    var instrumentValue: String
    var color: Color
    var instrumentUnits: String
    var unitsColor: Color
    var fontSize: CGFloat
    var withIndicator: Bool
    var indicatorAdjustment: Int
    
    var body: some View {
        HStack() {
            Text(instrumentName)
                .font(.body)
                .bold()
                .rotationEffect(Angle(degrees: -90))
                .foregroundColor(unitsColor)
            if withIndicator {
                ArrowView(
                    color: color,
                    angle: indicatorAdjustment+Int(instrumentValue)!,
                    width: 10,
                    height: 25
                )
                .frame(width: 10)
            }
            Spacer()
            Text(instrumentValue)
                .font(.system(size: fontSize).monospacedDigit())
                .fontWidth(.compressed)
                .bold()
                .padding(.top, -40)
                .padding(.bottom, -40)
                .foregroundColor(color)
            Spacer()
            Text(instrumentUnits)
                .rotationEffect(Angle(degrees: -90))
                .font(.body)
                .bold()
                .foregroundColor(unitsColor)
        }
    }
}

#Preview {
    struct Preview: View {
        var body: some View {
            InstrumentView(
                instrumentName: "W.DIR",
                instrumentValue: "100",
                color: Color.blue,
                instrumentUnits: "KTS",
                unitsColor: Color.blue,
                fontSize: 200,
                withIndicator: true,
                indicatorAdjustment: 0
            )
        }
    }
    return Preview()
}
