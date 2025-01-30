//
//  ArrowView.swift
//  Sailing
//
//  Created by Gordon Aspin on 1/22/25.
//

import SwiftUI

struct ArrowView: View {
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

struct TransomView: View {
    var color: Color
    var angle: Int
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        VStack {
            Transom()
                .stroke(color, lineWidth: 1)
                .fill(color.opacity(0.5))
                .frame(width: width, height: height)
                .rotationEffect(.degrees(Double(angle)))
                .padding()
        }
        .padding()
    }
}

struct SideView: View {
    var color: Color
    var angle: Int
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        VStack {
            Side()
                .stroke(color, lineWidth: 1)
                .fill(color.opacity(0.5))
                .frame(width: width, height: height)
                .rotationEffect(.degrees(Double(angle)))
                .padding()
        }
        .padding()
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

struct Side: Shape {
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

struct Transom: Shape {
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
            ArrowView(color: color, angle: angle, width: width, height: width*2.5)
            SideView(color: color, angle: angle, width: width, height: width*2.5)
            TransomView(color: color, angle: angle, width: width, height: width*2.5)
        }
    }
    return Preview()
}
