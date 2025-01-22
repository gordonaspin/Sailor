//
//  CountDownView.swift
//  Sailing
//
//  Created by Gordon Aspin on 1/21/25.
//

import SwiftUI
import UserNotifications
import AudioToolbox

struct CountDownView: View {
    let tenMinutes = 600
    let fiveMinutes = 300
    let oneMinute = 60
    let fontSize: CGFloat = 180
    @Binding var color: Color
    var counter: CountDown
    
    var body: some View {
        HStack() {
            Spacer()
            Group {
                let mt = String("\(counter.countDownFrom / oneMinute / 10)")
                let mu = String("\(counter.countDownFrom / oneMinute % 10)")
                let st = String("\((counter.countDownFrom % oneMinute) / 10)")
                let su = String("\((counter.countDownFrom % oneMinute) % 10)")
                if counter.countDownFrom >= tenMinutes {
                    Text(mt)
                }
                if (counter.countDownFrom >= oneMinute) {
                    Text(mu)
                        .onDisappear() {
                        }
                    Text(":")
                }
                if (counter.countDownFrom > 9) {
                    Text(st)
                }
                Text(su)
            }
            .font(.system(size: fontSize).monospacedDigit())
            .fontWidth(.compressed)
            .bold()
            .foregroundColor(color)
            .onChange(of: counter.countDownFrom) {
                if counter.countDownFrom > fiveMinutes {
                    color = Color.green
                }
                else if counter.countDownFrom > oneMinute {
                    color = Color.yellow
                }
                else {
                    color = Color.red
                }
            }
            Spacer()
        }
    }
}
