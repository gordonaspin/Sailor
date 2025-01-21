//
//  TimerButtonView.swift
//  Sailing
//
//  Created by Gordon Aspin on 1/21/25.
//

import SwiftUI


struct TimerButtonView : View {
    @ObservedObject var counter: CountDown
    @Binding var arcFraction: CGFloat
    let color: Color = .blue
    
    var body: some View {
        HStack(spacing: 50) {
            Button {
                counter.isRunning.toggle()
                print("button toggled isRunning: \(counter.isRunning)")
            } label: {
                HStack(spacing: 15) {
                    Image(systemName: counter.isRunning ? "pause.fill" : "play.fill")
                        .foregroundColor(.white)
                    Text(counter.isRunning ? "Pause" : "Start")
                        .foregroundColor(.white)
                }
            }
            .padding(.vertical)
            .frame(width: 120)
            .background(color)
            .clipShape(Capsule())
            .shadow(radius: 6)
            Button {
                counter.restart()
                withAnimation {
                    arcFraction = CGFloat(CountDown.startFrom)
                }
            } label: {
                HStack(spacing: 15) {
                    Image(systemName: "arrow.clockwise")
                        .foregroundColor(color)
                    Text("Restart")
                        .foregroundColor(color)
                }
            }
            .padding(.vertical)
            .frame(width: 120)
            .background(
                Capsule()
                    .stroke(color, lineWidth: 2)
            )
            .shadow(radius: 6)
        }
    }
}
