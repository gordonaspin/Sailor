//
//  TimerButtonView.swift
//  Sailing
//
//  Created by Gordon Aspin on 1/21/25.
//

import SwiftUI


struct TimerButtonView : View {
    var countDown: CountDown
    @Binding var arcFraction: CGFloat
    let color: Color = .blue
    
    var body: some View {
        HStack(spacing: 50) {
            Button {
                countDown.isRunning.toggle()
                print("button toggled isRunning:", "\(countDown.isRunning)")
            } label: {
                HStack(spacing: 15) {
                    Image(systemName: countDown.isRunning ? "pause.fill" : "play.fill")
                        .foregroundColor(.white)
                    Text(countDown.isRunning ? "Pause" : "Start")
                        .foregroundColor(.white)
                }
            }
            .padding(.vertical)
            .frame(width: 120)
            .background(color)
            .clipShape(Capsule())
            .shadow(radius: 6)
            Button {
                countDown.restart()
                withAnimation {
                    arcFraction = CGFloat(CountDown.startValue)
                }
            } label: {
                HStack(spacing: 15) {
                    Image(systemName: "arrow.clockwise")
                        .foregroundColor(color)
                    Text(countDown.isRunning ? "Restart" : " Reset ")
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
#Preview {
    struct Preview: View {
        @State var countDown = CountDown()
        @State var arcFraction: CGFloat = 100.0
        var body: some View {
            TimerButtonView(countDown: countDown, arcFraction: $arcFraction)
                .environment(StopWatch())
        }
    }
    return Preview()
}
