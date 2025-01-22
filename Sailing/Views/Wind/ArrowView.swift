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
                .stroke(color, lineWidth: 2)
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

#Preview {
    struct Preview: View {
        var body: some View {
            let color: Color = .blue
            let angle: Int = 0
            let width: CGFloat = 10.0
            ArrowView(color: color, angle: angle, width: width, height: width*2.5)
        }
    }
    return Preview()
}
