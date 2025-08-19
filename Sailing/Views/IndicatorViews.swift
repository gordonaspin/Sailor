//
//  IndicatorViews.swift
//  Sailing
//
//  Created by Gordon Aspin on 1/22/25.
//

import SwiftUI

struct BeaufortWindIndicator: View {
    var color: Color
    var direction: Int
    var speed: Double
    var cloudCover: Double
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        ZStack {
            let lineWidth: CGFloat = width * 0.15
            if speed < 1
                {
                BeaufortCalmWind()
                    .stroke(color, lineWidth: lineWidth)
                    .frame(width: width, height: height)
                BeaufortCloudCoverOutline()
                    .stroke(color, lineWidth: lineWidth)
                    .frame(width: width, height: height)
                BeaufortCloudCover(cloudCover: cloudCover)
                    .stroke(color, lineWidth: lineWidth)
                    .fill(color.opacity(0.5))
                    .frame(width: width, height: height)
                    .padding()            }
            else {
                ZStack {
                    BeaufortWindArrow(knots: speed)
                        .stroke(color, lineWidth: lineWidth)
                        .fill(color.opacity(0.5))
                        .frame(width: width, height: height)
                        .padding()
                    BeaufortCloudCoverOutline()
                        .stroke(color, lineWidth: lineWidth)
                        .frame(width: width, height: height)
                    BeaufortCloudCover(cloudCover: cloudCover)
                        .stroke(color, lineWidth: lineWidth/2)
                        .fill(color.opacity(0.5))
                        .frame(width: width, height: height)
                        .padding()
                        .rotationEffect(.degrees(Double(-direction)))

                }
                .rotationEffect(.degrees(Double(direction)))
                .offset(x:-width/3*sin(Double.pi/180 * Double(direction)) , y: height/3*cos(Double.pi/180 * Double(direction)))
            }
        }
        .padding()
    }
}

struct ApparentWindAngleIndicator: View {
    var color: Color
    var angle: Int
    var width: CGFloat = 20
    var height: CGFloat = 40
    
    var body: some View {
        ZStack {
            BoatPlanView()
                .stroke(Color.gray, lineWidth: width * 0.1)
                .fill(Color.gray.opacity(0.5))
                .frame(width: width, height: height)
                .padding()
            Arrow()
                .stroke(color, lineWidth: width * 0.1)
                .fill(color.opacity(0.5))
                .frame(width: width, height: height / 2)
                .offset(x: 0, y: -height * 0.25)
                .rotationEffect(.degrees(Double(angle)))
                .padding()
        }
        .padding()
    }
}

struct ArrowIndicator: View {
    var color: Color
    var angle: Int
    var width: CGFloat = 10
    var height: CGFloat = 25
    
    var body: some View {
        VStack {
            Arrow()
                .stroke(color, lineWidth: width * 0.1)
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
    var width: CGFloat = 20
    var height: CGFloat = 40
    
    var body: some View {
        VStack {
            BoatTransomElevation()
                .stroke(color, lineWidth: width * 0.1)
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
    var width: CGFloat = 20
    var height: CGFloat = 40
    
    var body: some View {
        VStack {
            BoatSideElevation()
                .stroke(color, lineWidth: width * 0.1)
                .fill(color.opacity(0.5))
                .frame(width: width, height: height)
                .rotationEffect(.degrees(Double(angle)))
                .padding()
        }
        .padding()
    }
}

struct BeaufortCloudCover: Shape {
    var cloudCover: Double

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width: CGFloat = rect.width
        let height: CGFloat = rect.height
        let radius: CGFloat = width * 0.6
        let centerCloudCover: CGPoint = CGPoint(x: width / 2, y: height / 2)
        let eighths = Int((cloudCover * 8).rounded())

        switch eighths {
        case 0: break
        case 1:
            path.move(to: centerCloudCover)
            path.addLine(to: CGPoint(x: width / 2, y: centerCloudCover.y - radius))
            path.addLine(to: CGPoint(x: width / 2, y: centerCloudCover.y + radius))
        case 2:
            path.addArc(center: centerCloudCover, radius: radius, startAngle: .degrees(0), endAngle: .degrees(-90), clockwise: true)
            path.addLine(to: centerCloudCover)
        case 3:
            path.addArc(center: centerCloudCover, radius: radius, startAngle: .degrees(0), endAngle: .degrees(-90), clockwise: true)
            path.addLine(to: centerCloudCover)
            path.move(to: centerCloudCover)
            path.addLine(to: CGPoint(x: centerCloudCover.x + radius, y: centerCloudCover.y))
            path.move(to: centerCloudCover)
            path.addLine(to: CGPoint(x: centerCloudCover.x, y: centerCloudCover.y + radius))
        case 4:
            path.addArc(center: centerCloudCover, radius: radius, startAngle: .degrees(90), endAngle: .degrees(-90), clockwise: true)
        case 5:
            path.addArc(center: centerCloudCover, radius: radius, startAngle: .degrees(90), endAngle: .degrees(-90), clockwise: true)
            path.addLine(to: CGPoint(x: width / 2, y: centerCloudCover.y + radius))
            path.move(to: centerCloudCover)
            path.addLine(to: CGPoint(x: centerCloudCover.x - radius, y: centerCloudCover.y))
        case 6:
            path.addArc(center: centerCloudCover, radius: radius, startAngle: .degrees(180), endAngle: .degrees(-90), clockwise: true)
            path.addLine(to: centerCloudCover)
        case 7:
            path.move(to: CGPoint(x: centerCloudCover.x + width * 0.1, y: centerCloudCover.y))
            path.addArc(center: centerCloudCover, radius: radius, startAngle: .degrees(80), endAngle: .degrees(-80), clockwise: true)
            path.addLine(to: CGPoint(x: centerCloudCover.x + width * 0.1, y: centerCloudCover.y))
            path.move(to: CGPoint(x: centerCloudCover.x - width * 0.1, y: centerCloudCover.y))
            path.addArc(center: centerCloudCover, radius: radius, startAngle: .degrees(100), endAngle: .degrees(-100), clockwise: false)
        case 8:
            path.move(to: CGPoint(x: centerCloudCover.x + radius, y: centerCloudCover.y))
            path.addArc(center: centerCloudCover, radius: radius, startAngle: .degrees(0), endAngle: .degrees(360), clockwise: true)
        default: break
        }
        path.closeSubpath()
        return path
    }
}

struct BeaufortCalmWind: Shape {

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width: CGFloat = rect.width
        let height: CGFloat = rect.height
        let center: CGPoint = CGPoint(x: width / 2, y: height / 2)
        let calmRadius: CGFloat = width * 0.8
        path.addArc(center: center, radius: calmRadius, startAngle: .degrees(0), endAngle: .degrees(360), clockwise: true)
        path.closeSubpath()
        return path
    }
}

struct BeaufortCloudCoverOutline: Shape {

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width: CGFloat = rect.width
        let height: CGFloat = rect.height
        let center: CGPoint = CGPoint(x: width / 2, y: height / 2)
        let radius: CGFloat = width * 0.6
        path.addArc(center: center, radius: radius, startAngle: .degrees(0), endAngle: .degrees(360), clockwise: true)
        path.closeSubpath()
        return path
    }
}
struct BeaufortWindArrow: Shape {
    var knots: Double

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width: CGFloat = rect.width
        let height: CGFloat = rect.height
        let center: CGPoint = CGPoint(x: width / 2, y: height / 2)
        let half: CGFloat = width * 0.4
        let full: CGFloat = width * 0.8
        let delta: CGFloat = height / 8
        let radius: CGFloat = width*0.6

        path.move(to: CGPoint(x: width / 2, y: -radius /*-2*/)) // Arrow tip
        path.addLine(to: CGPoint(x: width / 2, y: center.y-radius))
        
        let basey: CGFloat = -radius * 0.9 - width * 0.02//-2
        let basex: CGFloat = width / 2.0 - width * 0.01
        if knots < 48 {
            // first fletching
            if knots >= 1 { // beaufort 1
                path.move(to: CGPoint(x: basex, y: basey))
                path.addLine(to: CGPoint(x: basex + half, y: basey - delta))
            }
            if knots >= 4 { // beaufort 2
                path.move(to: CGPoint(x: basex + half, y: basey - delta))
                path.addLine(to: CGPoint(x: basex + full, y: basey - 2*delta))
            }
            // second fletching
            if knots >= 7 { // beaufort 3
                path.move(to: CGPoint(x: basex, y: basey + delta))
                path.addLine(to: CGPoint(x: basex + half, y: basey + delta - delta))
            }
            if knots >= 11 { // beaufort 4
                path.move(to: CGPoint(x: basex + half, y: basey + delta - delta))
                path.addLine(to: CGPoint(x: basex + full, y: basey + delta - 2*delta))
            }
            // third fletching
            if knots >= 17 { // beaufort 5
                path.move(to: CGPoint(x: basex, y: basey + 2*delta ))
                path.addLine(to: CGPoint(x: basex + half, y: basey + 2*delta - delta ))
            }
            if knots >= 22 { // beaufort 6
                path.move(to: CGPoint(x: basex + half, y: basey + 2*delta - delta ))
                path.addLine(to: CGPoint(x: basex + full, y: basey + 2*delta - 2*delta ))
            }
            // fourth fletching
            if knots >= 28 { // beaufort 7
                path.move(to: CGPoint(x: basex, y: basey + 3*delta ))
                path.addLine(to: CGPoint(x: basex + half, y: basey + 3*delta - delta ))
            }
            if knots >= 34 { // beaufort 8
                path.move(to: CGPoint(x: basex + half, y: basey + 3*delta - delta))
                path.addLine(to: CGPoint(x: basex + full, y: basey + 4*delta - 3*delta ))
            }
            // fifth fletching
            if knots >= 41 { // beaufort 9
                path.move(to: CGPoint(x: basex, y: basey + 4*delta ))
                path.addLine(to: CGPoint(x: basex + half, y: basey + 4*delta - delta))
            }
        }
        else {
            if knots >= 48 { // beaufort 10
                path.move(to: CGPoint(x: basex, y: basey))
                path.addLine(to: CGPoint(x: basex + full, y: basey - delta))
                path.addLine(to: CGPoint(x: basex , y: basey + 2*delta))
            }
            if knots >= 56 { // beaufort 11
                path.move(to: CGPoint(x: basex, y: basey + 3*delta))
                path.addLine(to: CGPoint(x: basex + half, y: basey + 3*delta - delta))
            }
            if knots >= 64 { // beaufort 12
                path.move(to: CGPoint(x: basex + half, y: basey + 3*delta - delta))
                path.addLine(to: CGPoint(x: basex + full, y: basey + 3*delta - 2*delta))
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
        let centerX = width / 2
        let headLength = height / 4
        let shaftWidth = width / 8
        let headWidth = width / 4
        
        path.move(to: CGPoint(x: centerX, y: 0))                  // Arrow tip
        path.addLine(to: CGPoint(x: centerX + headWidth, y: headLength))          // RHS tip
        path.addLine(to: CGPoint(x: centerX + shaftWidth, y: headLength))    // Bottom of RHS tip
        path.addLine(to: CGPoint(x: centerX + shaftWidth, y: height))        // Botton RH corner of Arrow
        path.addLine(to: CGPoint(x: centerX - shaftWidth, y: height))          // Bottom of Arrow
        path.addLine(to: CGPoint(x: centerX - shaftWidth, y: headLength))      // Bottom of LHS armpit
        path.addLine(to: CGPoint(x: centerX - headWidth, y: headLength))              // Bottom of LHS tip
        path.closeSubpath()
        
        return path
    }
}

struct BoatPlanView: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height
        let controlPointDivisor : CGFloat = 2
        let transomWidth : CGFloat = width * 0.5
        let beamFactor = width / 4
        let controlPointTopLeft = CGPoint(x: -beamFactor, y: height / controlPointDivisor)
        let controlPointTopRight = CGPoint(x: width + beamFactor, y: height / controlPointDivisor)

        //path.move(to: CGPoint(x: width / 2, y: 0)) // Boat Bow
        path.move(to: CGPoint(x: width / 2, y: 0)) // Bow point
        
        // Curve from bow to the port transom
        path.addQuadCurve(to: CGPoint(x: width / 2 - transomWidth / 2, y: height), control: controlPointTopLeft)
        
        // Transom
        path.addLine(to: CGPoint(x: width / 2 + transomWidth / 2, y: height))
        
        // Curve from starboard transom to bow
        path.addQuadCurve(to: CGPoint(x: width/2, y: 0), control: controlPointTopRight)
        path.closeSubpath()
        
        return path
    }
}

struct BoatSideElevation: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height
        let centerX = width / 2
        let mastOffset = width / 4
        let hullDepth = height / 15
        let topOfDeck = height * 0.8
        let boomHeight = height * 0.7
        let centerboardWidth = width / 12
        let centerboardDepth = height / 15
        
        path.move(to: CGPoint(x: centerX + mastOffset, y: 0)) // Mast tip
        path.addLine(to: CGPoint(x: centerX + mastOffset, y: topOfDeck)) // mast
        path.move(to: CGPoint(x: centerX + mastOffset, y: topOfDeck * 0.15)) // forestay tip
        path.addLine(to: CGPoint(x: width, y: topOfDeck)) // forestay
        path.move(to: CGPoint(x: centerX + mastOffset, y: 0)) // Mast tip
        path.addLine(to: CGPoint(x: 0, y: boomHeight)) // leech of main
        path.addLine(to: CGPoint(x: centerX + mastOffset, y: boomHeight)) // boom
        path.move(to: CGPoint(x: 0, y: topOfDeck)) // transom deck on LHS
        path.addLine(to: CGPoint(x: width, y: topOfDeck)) // deck
        path.addLine(to: CGPoint(x: width * 0.9, y: topOfDeck + hullDepth)) // bow
        path.addLine(to: CGPoint(x: 0, y: topOfDeck + hullDepth)) // base of hull
        path.addLine(to: CGPoint(x: 0, y: topOfDeck - width * 0.05)) // transom
        path.move(to: CGPoint(x: centerX, y: topOfDeck + hullDepth )) // center bottom of hull
        path.addLine(to: CGPoint(x: centerX - width * 0.025, y: topOfDeck + hullDepth + centerboardDepth)) // trailing edge of centerboard
        path.addLine(to: CGPoint(x: centerX - width * 0.05 + centerboardWidth, y: topOfDeck + hullDepth + centerboardDepth)) // trailing edge of centerboard
        path.addLine(to: CGPoint(x: centerX + centerboardWidth, y: topOfDeck + hullDepth))
        path.closeSubpath()
        
        return path
    }
}

struct BoatTransomElevation: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height
        
        let topWidth = width * 0.8
        let bottomWidth = topWidth * 0.1
        let topOfHull = height * 0.8
        let bottomOfHull = height * 0.9
        let topOfHounds = height * 0.15
        
        // hull shape
        let topLeft = CGPoint(x: width / 2 - topWidth / 2 , y: topOfHull)
        let topRight = CGPoint(x: width / 2 - topWidth / 2 + topWidth , y: topOfHull)
        let bottomLeft = CGPoint(x: width / 2 - bottomWidth / 2, y: bottomOfHull )
        let bottomRight = CGPoint(x: width / 2 + bottomWidth / 2, y: bottomOfHull)
        
        path.move(to: topLeft)
        path.addLine(to: topRight)
        path.addQuadCurve(to: bottomRight, control: CGPoint(x: width / 2 + topWidth / 2, y: bottomOfHull ))
        path.addLine(to: bottomLeft)
        path.addQuadCurve(to: topLeft, control: CGPoint(x: width / 2 - topWidth / 2, y: bottomOfHull))
        
        path.move(to: CGPoint(x: width / 2, y: 0)) // Mast tip
        path.addLine(to: CGPoint(x: width / 2, y: topOfHull)) // mast
        path.move(to: CGPoint(x: width / 2, y: topOfHounds)) // hounds
        path.addLine(to: topLeft) // left shroud
        path.move(to: CGPoint(x: width / 2, y: topOfHounds)) // hounds
        path.addLine(to: topRight) // right shroud
        path.move(to: CGPoint(x: width/2, y: bottomOfHull )) // center bottom of hull
        path.addLine(to: CGPoint(x: width/2, y: height))
        path.closeSubpath()
        
        return path
    }
}

#Preview {
    struct Preview: View {
        var body: some View {
            let color: Color = .blue
            let angle: Int = 135
            let width: CGFloat = 40
            ArrowIndicator(color: color, angle: angle, width: width, height: width*2.5)
            ApparentWindAngleIndicator(color: color, angle: angle, width: width, height: width*2.5)
            PitchIndicator(color: color, angle: angle, width: width, height: width*2.5)
            HeelIndicator(color: color, angle: angle, width: width, height: width*2.5)
            BeaufortWindIndicator(color: color, direction: angle, speed: 7.8, cloudCover: 0.125*4, width: width, height: width*2.5)
        }
    }
    return Preview()
}
