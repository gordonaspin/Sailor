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
    @ViewBuilder var indicator: () -> Content
    
    var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .center) {
                ZStack(alignment: .trailing) {
                    Text(instrumentName)
                        .font(.system(size: 18))
                        .bold()
                        .frame(width: 60, height: 100)
                        .rotationEffect(Angle(degrees: -90))
                        .foregroundColor(instrumentColor)
                    
                    self.indicator()
                        .frame(width: 10)
                        .offset(x: 10)
                }
                
                
                Text(formattedValue)
                    .font(.system(size: geometry.size.height).monospacedDigit())
                    .minimumScaleFactor(0.01)
                    .fontWidth(.compressed)
                    .bold()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.top, 0)
                    .padding(.bottom, 0)
                    .foregroundColor(instrumentValueColor)
                
                Text(instrumentTag)
                    .font(.system(size: 18))
                    .bold()
                    .frame(width: 60)//, height: 100)
                    .rotationEffect(Angle(degrees: -90))
                    .foregroundColor(instrumentTagColor)
            }
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
                indicator: {  BeaufortWindIndicator(color: Color.blue, direction: 310, speed: 45, cloudCover: 0.125*5, width: 10, height: 25)
                }
            )
        }
    }
    return Preview()
}
