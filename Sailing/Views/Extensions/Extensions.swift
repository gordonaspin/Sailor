//
//  Extensions.swift
//  Sailor
//
//  Created by Gordon Aspin on 1/8/25.
//

import SwiftUI

extension Date {

    var toTimestamp: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd H:mm:ss.SSS"
        return formatter.string(from: self)
    }
    
    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}

// swipe() extension on any view. Example:
//    var body: some View {
//    Text("Hello, World!")
//        .swipe(
//           up: {
//            doUp()
//            },
//           down: {
//            doDown()
//            })/
//           left: {
//            doLeft()
//            },
//           right: {
//            doRight()
//            })/
//}

extension View {
    func swipe(
        up:     @escaping (() -> Void) = {},
        down:   @escaping (() -> Void) = {},
        left:   @escaping (() -> Void) = {},
        right:  @escaping (() -> Void) = {}
    ) -> some View {
        return self.gesture(DragGesture(minimumDistance: 10, coordinateSpace: .local)
            .onEnded({
                value in
                if abs(value.translation.width) < abs(value.translation.height) {
                    // dominant motion was up/down
                    if value.translation.height < 0 {
                        up() }
                    if value.translation.height > 0 {
                        down() }
                }
                else {
                    if value.translation.width < 0 {
                        left() }
                    if value.translation.width > 0 {
                        right() }
                }
            }))
    }
}
