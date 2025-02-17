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
            if speed < 1
                {
                BeaufortCalmWind(centerX: width/2, centerY: height/2)
                    .stroke(color, lineWidth: 1)
                    .frame(width: width, height: height)
                BeaufortCloudCoverOutline(centerX: width/2, centerY: height/2)
                    .stroke(color, lineWidth: 1)
                    .frame(width: width, height: height)
                BeaufortCloudCover(cloudCover: cloudCover, centerX: width/2, centerY: height/2)
                    .stroke(color, lineWidth: 1)
                    .fill(color.opacity(0.5))
                    .frame(width: width, height: height)
                    .padding()            }
            else {
                ZStack {
                    BeaufortWindArrow(knots: speed, centerX: width/2, centerY: height/2)
                        .stroke(color, lineWidth: 1)
                        .fill(color)
                        .frame(width: width, height: height)
                        .padding()
                    BeaufortCloudCoverOutline(centerX: width/2, centerY: height/2)
                        .stroke(color, lineWidth: 1)
                        .frame(width: width, height: height)
                    BeaufortCloudCover(cloudCover: cloudCover, centerX: width/2, centerY: height/2)
                        .stroke(color, lineWidth: 1)
                        .fill(color.opacity(0.5))
                        .frame(width: width, height: height)
                        .padding()
                        .rotationEffect(.degrees(Double(-direction)))

                }
                .rotationEffect(.degrees(Double(direction)))
                .offset(x:0 , y: 6*cos(Double.pi/180 * Double(direction)))
            }
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

struct BeaufortCloudCover: Shape {
    var cloudCover: Double
    var centerX: Double
    var centerY: Double
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width: CGFloat = rect.width
        let radius: CGFloat = 6
        let centerCloudCover: CGPoint = CGPoint(x: centerX, y: centerY)
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
            path.addLine(to: CGPoint(x: width+1, y: centerCloudCover.y))
            path.move(to: centerCloudCover)
            path.addLine(to: CGPoint(x: width / 2, y: centerCloudCover.y + radius))
        case 4:
            path.addArc(center: centerCloudCover, radius: radius, startAngle: .degrees(90), endAngle: .degrees(-90), clockwise: true)
        case 5:
            path.addArc(center: centerCloudCover, radius: radius, startAngle: .degrees(90), endAngle: .degrees(-90), clockwise: true)
            path.addLine(to: CGPoint(x: width / 2, y: centerCloudCover.y + radius))
            path.move(to: centerCloudCover)
            path.addLine(to: CGPoint(x: -1, y: centerCloudCover.y))
        case 6:
            path.addArc(center: centerCloudCover, radius: radius, startAngle: .degrees(180), endAngle: .degrees(-90), clockwise: true)
            path.addLine(to: centerCloudCover)
        case 7:
            path.move(to: CGPoint(x: centerX + 1, y: centerY))
            path.addArc(center: centerCloudCover, radius: radius, startAngle: .degrees(80), endAngle: .degrees(-80), clockwise: true)
            path.addLine(to: CGPoint(x: centerX + 1, y: centerY))
            path.move(to: CGPoint(x: centerX - 1, y: centerY))
            path.addArc(center: centerCloudCover, radius: radius, startAngle: .degrees(100), endAngle: .degrees(-100), clockwise: false)
        case 8:
            path.move(to: CGPoint(x: centerX + radius, y: centerY))
            path.addArc(center: centerCloudCover, radius: radius, startAngle: .degrees(0), endAngle: .degrees(360), clockwise: true)
        default: break
        }
        path.closeSubpath()
        return path
    }
}

struct BeaufortCalmWind: Shape {
    var centerX: Double
    var centerY: Double
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let calmRadius: CGFloat = 8
        let center = CGPoint(x: centerX, y: centerY)
        path.addArc(center: center, radius: calmRadius, startAngle: .degrees(0), endAngle: .degrees(360), clockwise: true)
        path.closeSubpath()
        return path
    }
}

struct BeaufortCloudCoverOutline: Shape {
    var centerX: Double
    var centerY: Double
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let radius: CGFloat = 6
        let center = CGPoint(x: centerX, y: centerY)
        path.addArc(center: center, radius: radius, startAngle: .degrees(0), endAngle: .degrees(360), clockwise: true)
        path.closeSubpath()
        return path
    }
}
struct BeaufortWindArrow: Shape {
    var knots: Double
    var centerX: Double
    var centerY: Double
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width: CGFloat = rect.width
        let half: CGFloat = 4
        let full: CGFloat = 8
        let delta: CGFloat = 3
        let radius: CGFloat = 6

        path.move(to: CGPoint(x: width / 2, y: -radius-2)) // Arrow tip
        path.addLine(to: CGPoint(x: width / 2, y: centerY-radius))
        
        let basey: CGFloat = -radius-2
        let basex: CGFloat = width / 2.0
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
                path.move(to: CGPoint(x: basex, y: 0))
                path.addLine(to: CGPoint(x: basex + full, y: basey - delta))
                path.addLine(to: CGPoint(x: basex , y: basey + delta))
            }
            if knots >= 56 { // beaufort 11
                path.move(to: CGPoint(x: basex, y: basey + 2*delta))
                path.addLine(to: CGPoint(x: basex + half, y: basey + 2*delta - delta))
            }
            if knots >= 64 { // beaufort 12
                path.move(to: CGPoint(x: basex + half, y: basey + 2*delta - delta))
                path.addLine(to: CGPoint(x: basex + full, y: basey + 2*delta - 2*delta))
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
            let angle: Int = 330
            let width: CGFloat = 10.0
            ArrowIndicator(color: color, angle: angle, width: width, height: width*2.5)
            ApparentWindAngleIndicator(color: color, angle: angle, width: width, height: width*2.5)
            PitchIndicator(color: color, angle: angle, width: width, height: width*2.5)
            HeelIndicator(color: color, angle: angle, width: width, height: width*2.5)
            BeaufortWindIndicator(color: color, direction: angle, speed: 0, cloudCover: 0.125*7, width: width, height: width*2.5)
        }
    }
    return Preview()
}
