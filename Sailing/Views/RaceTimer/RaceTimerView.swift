//
//  RaceTimerView.swift
//  Sailor
//
//  Created by Gordon Aspin on 1/21/25.
//

import SwiftUI
import UserNotifications
import AudioToolbox
import AVFoundation

@Observable
class StopWatch: ObservableObject {
    static var shared = StopWatch(countDown: nil)
    var countDown: CountDown?
    var counter: Int = 0
    var timer: Timer? = nil
    init(countDown: CountDown? = nil) {
        self.countDown = countDown
    }
    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.counter += 1
            print("\(Date().toTimestamp) -  \(#file) \(#function) stopwatch tick \(self.counter)")
            if self.countDown != nil && self.countDown!.isRunning {
                self.countDown?.notify()
            }
            else {
                self.stop()
            }
        }
    }
    func stop() {
        timer?.invalidate()
    }
    func reset() {
        counter = 0
        timer?.invalidate()
    }
}

@Observable
class CountDown: ObservableObject {
    let oneMinute: Int = 60
    static private var settings = RaceTimerSettings.shared
    static var shared = CountDown()
    let synthesizer = AVSpeechSynthesizer()
    let events = [5*60, 4*60, 3*60, 2*60, 60, 30, 15, 10, 5, 4, 3, 2, 1, 0]

    static var startValue: Int = settings.raceTimer
    let increment: Int = 1
    var value: Int
    var isRunning: Bool
    init() {
        value = CountDown.startValue
        isRunning = false
    }
    func restart() {
        value = CountDown.startValue
    }
    func reset() {
        value = CountDown.startValue
        isRunning = false
    }
    func notify() {
        guard isRunning else { return }
        value -= increment
        print("\(Date().toTimestamp) -  \(#file) \(#function) countDown notify \(value)")
        if events.contains(value) {
            print("\(Date().toTimestamp) -  \(#file) \(#function) countDown notify event \(value)")
            AudioServicesPlayAlertSound(1313)
            if value > 0 {
                if value >= oneMinute {
                    synthesizer.speak(AVSpeechUtterance(string: "\(value/oneMinute) minute\(value > oneMinute ? "s" : "")"))
                }
                else if value < oneMinute && value > 5 {
                    synthesizer.speak(AVSpeechUtterance(string: "\(value) seconds"))
                }
                else if value <= 5 && value > 0 {
                    synthesizer.speak(AVSpeechUtterance(string: "\(value)"))
                }
            }
            else {
                isRunning = false
                synthesizer.speak(AVSpeechUtterance(string: "start racing, good luck!"))
            }
        }
    }
}

struct RaceTimerView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(StopWatch.self) var stopWatch
    @Environment(CountDown.self) var countDown
    @StateObject private var settings = RaceTimerSettings.shared
    @State private var isPickerPresented: Bool = false
    @State var arcFraction: CGFloat = 0
    @State var timerColor = Color.green
    @Binding var isPresented: Bool
    @Binding var viewIndex: Int

    var body: some View {
        ZStack {
            GeometryReader { geometry in
                if geometry.size.height > geometry.size.width {
                    VStack() {
                        Spacer()
                        ZStack() {
                            CircleView(color: $timerColor, fraction: $arcFraction)
                        }
                        .frame(width: 280, height: 280)
                        CountDownView(color: $timerColor, counter: countDown)
                        Spacer()
                        TimerButtonView(counter: countDown, arcFraction: $arcFraction)
                        Spacer()
                    }
                }
                else {
                    HStack() {
                        Spacer()
                        ZStack {
                            CircleView(color: $timerColor, fraction: $arcFraction)
                        }
                        .frame(width: 280, height: 280)
                        VStack {
                            CountDownView(color: $timerColor, counter: countDown)
                            Spacer()
                            TimerButtonView(counter: countDown, arcFraction: $arcFraction)
                            Spacer()
                        }
                        Spacer()
                    }
                }
            }
        }
        .onChange(of: countDown.isRunning) {
            print("\(Date().toTimestamp) -  \(#file) \(#function) onchange countdown running \(countDown.isRunning)")
            if countDown.isRunning {
                stopWatch.start()
            }
            else {
                stopWatch.stop()
            }
        }
        .onChange(of: countDown.value) {
            print("\(Date().toTimestamp) -  \(#file) \(#function) countDown counter changed \(countDown.value)")
            //if countDown.isRunning {
                if countDown.value > 0 {
                    withAnimation(.default) {
                        arcFraction = CGFloat(countDown.value) / CGFloat(CountDown.startValue)
                    }
                } else {
                    withAnimation(.default) {
                        arcFraction = CGFloat(CountDown.startValue)
                    }
                    dissmissMe()
                    notify()
                }
            //}
        }
        .onAppear(perform: {
            UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert]) { _, _ in
            }
            print("\(Date().toTimestamp) -  \(#file) \(#function) RaceTimerView onAppear: countdown.isRunning \(countDown.isRunning)")
            if !countDown.isRunning {
                countDown.reset()
            }
        })
        .onTapGesture(count: 2) {
            isPickerPresented = true
        }
        .onChange(of: settings.raceTimer) {
            countDown.value = settings.raceTimer
            CountDown.startValue = settings.raceTimer
        }
        .sheet(isPresented: $isPickerPresented) {
            RaceTimerSettingsView(
                timerStartValue: settings.$raceTimer,
                raceTimerValues: settings.raceTimerValues
            )
        }
    }
    private func dissmissMe() {
        countDown.reset()
        if viewIndex < 0 {
            viewIndex = viewIndex + 1
        }
        else {
            viewIndex = viewIndex - 1
        }
        isPresented.toggle()
    }
    private func notify() {
        let content = UNMutableNotificationContent()
        content.title = "Sailing"
        content.body = "Race has started!"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let req = UNNotificationRequest(identifier: "MSF", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(req, withCompletionHandler: nil)
    }
}

#Preview {
    struct Preview: View {
        @State var isPresented: Bool = true
        @State var viewIndex: Int = 0
        var body: some View {
            RaceTimerView(isPresented: $isPresented, viewIndex: $viewIndex)
                .environment(StopWatch(countDown: CountDown()))
                .environment(CountDown())
        }
    }
    return Preview()
}
