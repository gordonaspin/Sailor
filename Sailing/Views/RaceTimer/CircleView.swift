//
//  CircleView.swift
//  Sailing
//
//  Created by Gordon Aspin on 1/21/25.
//

import SwiftUI

struct CircleView: View {
    @Binding var color: Color
    @Binding var fraction: CGFloat
    
    var body: some View {
            Circle()
                .trim(from: 0, to: 1)
                .stroke(.gray.opacity(0.5), style: StrokeStyle(lineWidth: 35, lineCap: .round))
            Circle()
                .trim(from: 0, to: fraction)
                .stroke(color, style: StrokeStyle(lineWidth: 35, lineCap: .round))
                .rotationEffect(.init(degrees: 270))
    }
}
