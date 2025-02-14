//
//  IndicatorViews.swift
//  Sailing
//
//  Created by Gordon Aspin on 1/22/25.
//

import SwiftUI

struct WindIndicator: View {
    var color: Color
    var angle: Int
    var speed: Double
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        VStack {
            BeaufortScaleShape(speed: speed)
                .stroke(color, lineWidth: 1)
                .fill(speed >= 1 ? color.opacity(0.5) : Color.clear)
                .frame(width: width, height: height)
                .rotationEffect(.degrees(Double(angle)))
                .padding()
        }
        .padding()
    }
}

struct ApparentWindAngleIndicator: View {
    var color: Color
    var angle: Int
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        ZStack {
            BoatPlanView()
                .stroke(Color.gray, lineWidth: 1)
                .fill(Color.gray.opacity(0.5))
                .frame(width: width, height: height)
                .padding()
            Arrow()
                .stroke(color, lineWidth: 1)
                .fill(color.opacity(0.5))
                .frame(width: width, height: height)
                .rotationEffect(.degrees(Double(angle)))
                .padding()
        }
        .padding()
    }
}

struct ArrowIndicator: View {
    var color: Color
    var angle: Int
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        VStack {
            Arrow()
                .stroke(color, lineWidth: 1)
                .fill(color.opacity(0.5))
                .frame(width: width, height: height)
                .rotationEffect(.degrees(Double(angle)))
                .padding()
        }
        .padding()
    }
}

struct HeelIndicator: View {
    var color: Color
    var angle: Int
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        VStack {
            BoatTransomElevation()
                .stroke(color, lineWidth: 1)
                .fill(color.opacity(0.5))
                .frame(width: width, height: height)
                .rotationEffect(.degrees(Double(angle)))
                .padding()
        }
        .padding()
    }
}

struct PitchIndicator: View {
    var color: Color
    var angle: Int
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        VStack {
            BoatSideElevation()
                .stroke(color, lineWidth: 1)
                .fill(color.opacity(0.5))
                .frame(width: width, height: height)
                .rotationEffect(.degrees(Double(angle)))
                .padding()
        }
        .padding()
    }
}

struct BeaufortScaleShape: Shape {
    var speed: Double
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height
        let half = 5
        let full = 10
        let delta = 3
        
        if speed < 1 {
            path.move(to: CGPoint(x: 2 + width / 2, y: height / 2))
            path.addArc(center: CGPoint(x: width / 2, y: height / 2), radius: 2, startAngle: .degrees(0), endAngle: .degrees(360), clockwise: true)
            path.move(to: CGPoint(x: CGFloat(full) + width / 2, y: height / 2))
            path.addArc(center: CGPoint(x: width / 2, y: height / 2), radius: CGFloat(full), startAngle: .degrees(0), endAngle: .degrees(360), clockwise: true)        }
        else {
            path.move(to: CGPoint(x: width / 2, y: 0)) // Arrow tip
            path.addLine(to: CGPoint(x: width / 2, y: height - 2))
            path.move(to: CGPoint(x: 2 + width / 2, y: height))
            path.addArc(center: CGPoint(x: width / 2, y: height), radius: 2, startAngle: .degrees(0), endAngle: .degrees(360), clockwise: true)
        }
        if speed < 55 {
            if speed >= 1 { // beaufort 1
                path.move(to: CGPoint(x: width / 2, y: 0))
                path.addLine(to: CGPoint(x: Int(width) / 2 + half, y: 0))
            }
            if speed >= 4 { // beaufort 2
                path.addLine(to: CGPoint(x: Int(width) / 2 + full, y: 0))
            }
            if speed >= 8 { // beaufort 3
                path.move(to: CGPoint(x: Int(width) / 2, y: delta ))
                path.addLine(to: CGPoint(x: Int(width) / 2 + half, y: delta ))
            }
            if speed >= 13 { // beaufort 4
                path.move(to: CGPoint(x: Int(width) / 2, y: delta ))
                path.addLine(to: CGPoint(x: Int(width) / 2 + full, y: delta ))
            }
            if speed >= 19 { // beaufort 5
                path.move(to: CGPoint(x: Int(width) / 2, y: 2*delta ))
                path.addLine(to: CGPoint(x: Int(width) / 2 + half, y: 2*delta ))
            }
            if speed >= 25 { // beaufort 6
                path.move(to: CGPoint(x: Int(width) / 2, y: 2*delta ))
                path.addLine(to: CGPoint(x: Int(width) / 2 + full, y: 2*delta ))
            }
            if speed >= 32 { // beaufort 7
                path.move(to: CGPoint(x: Int(width) / 2, y: 3*delta ))
                path.addLine(to: CGPoint(x: Int(width) / 2 + half, y: 3*delta ))
            }
            if speed >= 39 { // beaufort 8
                path.move(to: CGPoint(x: Int(width) / 2, y: 3*delta ))
                path.addLine(to: CGPoint(x: Int(width) / 2 + full, y: 3*delta ))
            }
            if speed >= 47 { // beaufort 9
                path.move(to: CGPoint(x: Int(width) / 2, y: 4*delta ))
                path.addLine(to: CGPoint(x: Int(width) / 2 + half, y: 4*delta ))
            }
        }
        else {
            if speed >= 55 { // beaufort 10
                path.move(to: CGPoint(x: width / 2, y: 0))
                path.addLine(to: CGPoint(x: Int(width) / 2 + full, y: 2*delta))
                path.addLine(to: CGPoint(x: Int(width) / 2 , y: 2*delta))
            }
            if speed >= 64 { // beaufort 11
                path.move(to: CGPoint(x: Int(width) / 2, y: 3*delta))
                path.addLine(to: CGPoint(x: Int(width) / 2 + half, y: 3*delta))
            }
            if speed >= 75 { // beaufort 12
                path.move(to: CGPoint(x: Int(width) / 2, y: 3*delta))
                path.addLine(to: CGPoint(x: Int(width) / 2 + full, y: 3*delta))
            }
        }
        path.closeSubpath()
        
        return path
    }
}

struct Arrow: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height
        
        path.move(to: CGPoint(x: width / 2, y: 0)) // Arrow tip
        path.addLine(to: CGPoint(x: width, y: height / 3))
        path.addLine(to: CGPoint(x: width * 3/4, y: height / 3))
        path.addLine(to: CGPoint(x: width * 3/4, y: height))
        path.addLine(to: CGPoint(x: width / 4, y: height))
        path.addLine(to: CGPoint(x: width / 4, y: height / 3))
        path.addLine(to: CGPoint(x: 0, y: height / 3))
        path.closeSubpath()
        
        return path
    }
}

struct BoatPlanView: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height
        
        //path.move(to: CGPoint(x: width / 2, y: 0)) // Boat Bow
        path.move(to: CGPoint(x: width / 2, y: -5)) // Bow point
                        
        // Curved bow to the left
        path.addQuadCurve(to: CGPoint(x: -2, y: height*0.6), control: CGPoint(x: -2, y: 5))
        
        // Bottom left corner of the boat
        path.addLine(to: CGPoint(x: -2, y: height + 5)) // Transom left
        
        // Bottom right corner of the boat
        path.addLine(to: CGPoint(x: width + 2, y: height + 5)) // Transom right

        // Starboard side to start of bow
        path.addLine(to: CGPoint(x: width + 2, y: height*0.6)) // Transom right

        // Curved bow to the right
        path.addQuadCurve(to: CGPoint(x: width/2, y: -5), control: CGPoint(x: width+2, y: 5))
                        
        path.closeSubpath()
        
        return path
    }
}

struct BoatSideElevation: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height
        
        path.move(to: CGPoint(x: width * 0.8, y: 0)) // Mast tip
        path.addLine(to: CGPoint(x: width * 0.8, y: height * 0.9)) // mast
        path.move(to: CGPoint(x: width * 0.8, y: height * 0.15)) // Mast tip
        path.addLine(to: CGPoint(x: width + 2, y: height * 0.9)) // forestay
        path.move(to: CGPoint(x: width * 0.8, y: 0)) // Mast tip
        path.addLine(to: CGPoint(x: -1, y: height * 0.80)) // leech of main
        path.addLine(to: CGPoint(x: width * 0.8, y: height * 0.80)) // boom
        path.move(to: CGPoint(x: 0, y: height)) // bottom of mast
        path.move(to: CGPoint(x: -2, y: height * 0.9)) // port side of deck
        path.addLine(to: CGPoint(x: width + 2, y: height * 0.9)) // deck
        path.addLine(to: CGPoint(x: width + 1, y: height)) // starboard freeboard
        path.addLine(to: CGPoint(x: -2, y: height)) // base of hull
        path.addLine(to: CGPoint(x: -2, y: height * 0.9)) // port side of deck
        path.move(to: CGPoint(x: width/2, y: height )) // center bottom of hull
        path.addLine(to: CGPoint(x: width/2*0.9, y: height + 4)) // centerboard
        path.closeSubpath()
        
        return path
    }
}

struct BoatTransomElevation: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height
        
        let topWidth = rect.width
        let bottomWidth = rect.width * 0.2

        // hull shape
        let topLeft = CGPoint(x: (rect.width - topWidth) / 2, y: height * 0.9)
        let topRight = CGPoint(x: rect.width - (rect.width - topWidth) / 2, y: height * 0.9)
        let bottomLeft = CGPoint(x: (rect.width - bottomWidth) / 2, y: height )
        let bottomRight = CGPoint(x: rect.width - (rect.width - bottomWidth) / 2, y: height)
        
        path.move(to: topLeft)
        path.addLine(to: topRight)
        path.addQuadCurve(to: bottomRight, control: CGPoint(x: rect.width * 1.1, y: rect.height ))
        path.addLine(to: bottomLeft)
        path.addQuadCurve(to: topLeft, control: CGPoint(x: -rect.width * 0.1, y: rect.height))
        
        path.move(to: CGPoint(x: width / 2, y: 0)) // Mast tip
        path.addLine(to: CGPoint(x: width / 2, y: height * 0.9)) // mast
        path.move(to: CGPoint(x: width / 2, y: height * 0.15)) // hounds
        path.addLine(to: CGPoint(x: 0, y: height * 0.9)) // left shroud
        path.move(to: CGPoint(x: width / 2, y: height * 0.15)) // hounds
        path.addLine(to: CGPoint(x: width, y: height * 0.9)) // right shroud
        path.move(to: CGPoint(x: width/2, y: height )) // center bottom of hull
        path.addLine(to: CGPoint(x: width/2, y: height + 4))
        path.closeSubpath()
        
        return path
    }
}

#Preview {
    struct Preview: View {
        var body: some View {
            let color: Color = .blue
            let angle: Int = 0
            let width: CGFloat = 10.0
            ArrowIndicator(color: color, angle: angle, width: width, height: width*2.5)
            ApparentWindAngleIndicator(color: color, angle: angle, width: width, height: width*2.5)
            PitchIndicator(color: color, angle: angle, width: width, height: width*2.5)
            HeelIndicator(color: color, angle: angle, width: width, height: width*2.5)
            WindIndicator(color: color, angle: angle, speed: 025, width: width, height: width*2.5)
        }
    }
    return Preview()
}
