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
                print("button toggled isRunning:", "\(counter.isRunning)")
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
                    arcFraction = CGFloat(CountDown.startValue)
                }
            } label: {
                HStack(spacing: 15) {
                    Image(systemName: "arrow.clockwise")
                        .foregroundColor(color)
                    Text(counter.isRunning ? "Restart" : " Reset ")
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
        @State var counter: CountDown = .init()
        @State var arcFraction: CGFloat = 100.0
        var body: some View {
            TimerButtonView(counter: counter, arcFraction: $arcFraction)
                .environment(StopWatch(countDown: CountDown()))
                .environment(CountDown())
        }
    }
    return Preview()
}
