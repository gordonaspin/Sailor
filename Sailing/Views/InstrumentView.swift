//
//  InstrumentView.swift
//  Sailing
//
//  Created by Gordon Aspin on 1/18/25.
//

import SwiftUI

struct InstrumentView<T: Numeric, Content: View>: View {
    var instrumentName: String
    var instrumentColor: Color
    var instrumentValue: T
    var instrumentValueColor: Color
    var formatSpecifier: String
    var showSign: Bool
    var instrumentTag: String
    var instrumentTagColor: Color
    var fontSize: CGFloat
    @ViewBuilder var indicator: () -> Content
    
    var body: some View {
        HStack() {
            Text(instrumentName)
                .font(.body)
                .bold()
                .frame(width: 60, height: 100)
                .rotationEffect(Angle(degrees: -90))
                .foregroundColor(instrumentColor)
            
            ZStack(alignment: .leading) {
                self.indicator()
                    .frame(width: 10)

                Text(formattedValue)
                    .font(.system(size: fontSize).monospacedDigit())
                    .fontWidth(.compressed)
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding(.top, -40)
                    .padding(.bottom, -40)
                    .foregroundColor(instrumentValueColor)
            }

            Text(instrumentTag)
                .rotationEffect(Angle(degrees: -90))
                .font(.body)
                .bold()
                .frame(width: 60, height: 100)
                .foregroundColor(instrumentTagColor)
        }
    }
    private var formattedValue: String {
        let valueString: String
        if let doubleValue = instrumentValue as? Double {
            valueString = String(format: formatSpecifier, abs(doubleValue))
        } else if let intValue = instrumentValue as? Int {
            valueString = String(format: formatSpecifier, abs(intValue))
        } else if let floatValue = instrumentValue as? Float {
            valueString = String(format: formatSpecifier, abs(floatValue))
        } else {
            valueString = "\(instrumentValue)"
        }
        
        if showSign {
            if let number = instrumentValue as? NSNumber {
                return number.doubleValue >= 0 ? "+\(valueString)" : "-\(valueString)"
            }
        }
        /*else {
            if let number = instrumentValue as? NSNumber, number.doubleValue < 0 {
                return valueString.trimmingCharacters(in: CharacterSet(charactersIn: "-"))
            }
        }*/
        return valueString
    }
    
}

#Preview {
    struct Preview: View {
        var body: some View {
            InstrumentView(
                instrumentName: "W.DIR",
                instrumentColor: Color.blue,
                instrumentValue: 10,
                instrumentValueColor: Color.blue,
                formatSpecifier: "%03d",
                showSign: false,
                instrumentTag: "KTS",
                instrumentTagColor: Color.blue,
                fontSize: 128,
                indicator: { ArrowView(
                    color: Color.blue,
                    angle: 10,
                    width: 10,
                    height: 25)
                }
            )
        }
    }
    return Preview()
}
