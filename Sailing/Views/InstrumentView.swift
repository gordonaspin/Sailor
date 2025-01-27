//
//  WidgetView.swift
//  Sailing
//
//  Created by Gordon Aspin on 1/18/25.
//

import SwiftUI

struct InstrumentView<T: Numeric>: View {
    var instrumentName: String
    var instrumentValue: T
    var formatSpecifier: String
    var showSign: Bool
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
                .frame(width: 60, height: 100)
                .rotationEffect(Angle(degrees: -90))
                .foregroundColor(unitsColor)
            if withIndicator {
                let intValue = instrumentValue as? Int
                ArrowView(
                    color: color,
                    angle: indicatorAdjustment+(intValue ?? 0),
                    width: 10,
                    height: 25
                )
                .frame(width: 10)
            } else {
                Text("")
                    .frame(width: 10)
            }
            Spacer()
            Text(formattedValue)
                .font(.system(size: fontSize).monospacedDigit())
                .fontWidth(.compressed)
                .bold()
                .frame(maxWidth: .infinity)
                .padding(.top, -40)
                .padding(.bottom, -40)
                .foregroundColor(color)
            Spacer()
            Text(instrumentUnits)
                .rotationEffect(Angle(degrees: -90))
                .font(.body)
                .bold()
                .frame(width: 60, height: 100)
                .foregroundColor(unitsColor)
        }
    }
    private var formattedValue: String {
        let valueString: String
        if let doubleValue = instrumentValue as? Double {
            valueString = String(format: formatSpecifier, doubleValue)
        } else if let intValue = instrumentValue as? Int {
            valueString = String(format: formatSpecifier, intValue)
        } else if let floatValue = instrumentValue as? Float {
            valueString = String(format: formatSpecifier, floatValue)
        } else {
            valueString = "\(instrumentValue)"
        }
        
        if showSign {
            if let number = instrumentValue as? NSNumber {
                return number.doubleValue >= 0 ? "+\(valueString)" : valueString
            }
        } else {
            if let number = instrumentValue as? NSNumber, number.doubleValue < 0 {
                return valueString.trimmingCharacters(in: CharacterSet(charactersIn: "-"))
            }
        }
        return valueString
    }
    
}

#Preview {
    struct Preview: View {
        var body: some View {
            InstrumentView(
                instrumentName: "W.DIR",
                instrumentValue: 10,
                formatSpecifier: "%03d",
                showSign: false,
                color: Color.blue,
                instrumentUnits: "KTS",
                unitsColor: Color.blue,
                fontSize: 128,
                withIndicator: false,
                indicatorAdjustment: 0
            )
        }
    }
    return Preview()
}
