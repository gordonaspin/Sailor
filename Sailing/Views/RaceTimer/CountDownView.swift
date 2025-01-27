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
            //Spacer()
            Group {
                let mt = String("\(counter.value / oneMinute / 10)")
                let mu = String("\(counter.value / oneMinute % 10)")
                let st = String("\((counter.value % oneMinute) / 10)")
                let su = String("\((counter.value % oneMinute) % 10)")
                if counter.value >= tenMinutes {
                    Text(mt)
                }
                if (counter.value >= oneMinute) {
                    Text(mu)
                        .onDisappear() {
                        }
                    Text(":")
                }
                if (counter.value > 9) {
                    Text(st)
                }
                Text(su)
            }
            .font(.system(size: fontSize).monospacedDigit())
            .fontWidth(.compressed)
            .bold()
            .foregroundColor(color)
            .onChange(of: counter.value) {
                if counter.value > fiveMinutes {
                    color = Color.green
                }
                else if counter.value > oneMinute {
                    color = Color.yellow
                }
                else {
                    color = Color.red
                }
            }
            //Spacer()
        }
        .frame(width: .infinity, height: 200)
    }
}
#Preview {
    CountDownView(color: .constant(.red), counter: .shared)
}
