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
    let tenMinutes = 10*60
    let fourMinutes = 4*60
    let oneMinute = 60
    let fontSize: CGFloat = 180
    @StateObject var countDown: CountDown
    @Binding var color: Color
    
    var body: some View {
        HStack() {
            Group {
                let mt = String("\(countDown.value / oneMinute / 10)")
                let mu = String("\(countDown.value / oneMinute % 10)")
                let st = String("\((countDown.value % oneMinute) / 10)")
                let su = String("\((countDown.value % oneMinute) % 10)")
                if countDown.value >= tenMinutes {
                    Text(mt)
                }
                if (countDown.value >= oneMinute) {
                    Text(mu)
                    Text(":")
                }
                if (countDown.value > 9) {
                    Text(st)
                }
                Text(su)
            }
            .font(.system(size: fontSize).monospacedDigit())
            .fontWidth(.compressed)
            .bold()
            .foregroundColor(color)
            .onChange(of: countDown.value) {
                if countDown.value > fourMinutes {
                    color = Color.green
                }
                else if countDown.value > oneMinute {
                    color = Color.orange
                }
                else {
                    color = Color.red
                }
            }
        }
    }
}
#Preview {
    CountDownView(countDown: CountDown(), color: .constant(.red))
}
