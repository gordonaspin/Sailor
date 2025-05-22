//
//  RaceTimerView.swift
//  Sailing
//
//  Created by Gordon Aspin on 1/21/25.
//

import SwiftUI
import UserNotifications
import AVFoundation

@Observable
class StopWatch: ObservableObject {
    let countDown: CountDown = CountDown()
    private var counter: Int = 0
    private var timer: Timer? = nil

    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.counter += 1
            print("stopwatch tick", "\(self.counter)")
            if self.countDown.isRunning {
                self.countDown.notify()
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
    private let oneMinute: Int = 60
    private let increment: Int = 1
    private let synthesizer = AVSpeechSynthesizer()
    private let events = [5*60, 4*60, 3*60, 2*60, 60, 45, 30, 15, 10, 5, 4, 3, 2, 1, 0]
    private let url = URL(fileURLWithPath: "/System/Library/Audio/UISounds/sms-received5.caf")
    static private var settings = RaceTimerSettings.shared
    static var startValue: Int = settings.raceTimer
    var value: Int
    var isRunning: Bool
    private var systemSoundID : SystemSoundID = 1013 // doesnt matter; edit path instead

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
        print("countDown notify:", "\(value)")
        if events.contains(value) {
            print("countDown notify event:", "\(value)")
            if CountDown.settings.audibleTimerAlerts {
                AudioServicesCreateSystemSoundID(url as CFURL, &systemSoundID)
                AudioServicesPlaySystemSound(systemSoundID)
            }
            if value > 0 && CountDown.settings.speakTimerAlerts {
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
            if value == 0 {
                isRunning = false
                let message = "Race has started! Good luck!"
                let identifier = Bundle.main.bundleIdentifier ?? ""
                if CountDown.settings.speakTimerAlerts {
                    synthesizer.speak(AVSpeechUtterance(string: message))
                }
                let content = UNMutableNotificationContent()
                content.title = "Sailing"
                content.body = message
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
                let req = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
                print("notification:", "\(identifier)", content.title, content.body)
                UNUserNotificationCenter.current().add(req, withCompletionHandler: nil)
            }
        }
    }
}

struct RaceTimerView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(StopWatch.self) var stopWatch
    @StateObject private var settings = RaceTimerSettings.shared
    @State private var isPickerPresented: Bool = false
    @State var arcFraction: CGFloat = 0
    @State var timerColor = Color.green
    @Binding var tabSelection: Int

    var body: some View {
        ZStack {
            GeometryReader { geometry in
                if geometry.size.height > geometry.size.width {
                    VStack(alignment: .center) {
                        Spacer()
                        ZStack() {
                            CircleView(color: $timerColor, fraction: $arcFraction)
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height / 3)
                        Spacer()
                        CountDownView(countDown: stopWatch.countDown, color: $timerColor)
                        Spacer()
                        TimerButtonView(countDown: stopWatch.countDown, arcFraction: $arcFraction)
                            .frame(width: geometry.size.width)
                        Spacer()
                    }
                }
                else {
                    HStack() {
                        Spacer()
                        ZStack {
                            CircleView(color: $timerColor, fraction: $arcFraction)
                        }
                        .frame(width: geometry.size.width / 3, height: geometry.size.height)
                        Spacer()
                        VStack {
                            Spacer()
                            CountDownView(countDown: stopWatch.countDown, color: $timerColor)
                            Spacer()
                            TimerButtonView(countDown: stopWatch.countDown, arcFraction: $arcFraction)
                            Spacer()
                        }
                        Spacer()
                    }
                }
            }
        }
        .onChange(of: stopWatch.countDown.isRunning) {
            print("onchange countdown running:", "\(stopWatch.countDown.isRunning)")
            if stopWatch.countDown.isRunning {
                stopWatch.start()
            }
            else {
                stopWatch.stop()
            }
        }
        .onChange(of: stopWatch.countDown.value) {
            print("countDown counter changed:", "\(stopWatch.countDown.value)")
            if stopWatch.countDown.value > 0 {
                withAnimation(.default) {
                    arcFraction = CGFloat(stopWatch.countDown.value) / CGFloat(CountDown.startValue)
                }
            } else {
                withAnimation(.default) {
                    arcFraction = CGFloat(CountDown.startValue)
                }
                dissmissMe()
            }
        }
        .onAppear(perform: {
            UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert]) { _, _ in
            }
            print("RaceTimerView onAppear: countdown.isRunning:", "\(stopWatch.countDown.isRunning)")
            if !stopWatch.countDown.isRunning {
                stopWatch.countDown.reset()
            }
        })
        .onTapGesture(count: 2) {
            isPickerPresented = true
        }
        .onChange(of: settings.raceTimer) {
            stopWatch.countDown.value = settings.raceTimer
            CountDown.startValue = settings.raceTimer
        }
        .sheet(isPresented: $isPickerPresented) {
            RaceTimerSettingsView(
                timerStartValue: settings.$raceTimer,
                raceTimerValues: settings.raceTimerValues,
                speakTimerAlerts: settings.$speakTimerAlerts,
                audibleTimerAlerts: settings.$audibleTimerAlerts
            )
        }
    }
    private func dissmissMe() {
        stopWatch.countDown.reset()
        tabSelection = tabs.race.rawValue
    }
}

#Preview {
    struct Preview: View {
        @State var selection: Int = 2
        var body: some View {
            RaceTimerView(tabSelection: $selection)
                .environment(StopWatch())
        }
    }
    return Preview()
}
