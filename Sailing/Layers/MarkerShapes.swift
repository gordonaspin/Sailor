//
//  MarkerShapes.swift
//  Sailing
//
//  Created by Gordon Aspin on 8/28/25.
//
import SwiftUI

struct Triangle: Shape {
    public init() {
    }
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX - rect.maxY / sqrt(3) /*rect.minX*/, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX + rect.maxY / sqrt(3) /*rect.maxX*/, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        return path
    }
}

struct Square: Shape {
    public init() {
    }
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))

        return path
    }
}

enum MarkerShape {
    case square
    case triangle
}
