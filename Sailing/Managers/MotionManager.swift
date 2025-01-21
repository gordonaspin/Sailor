//
//  MotionManager.swift
//  Sailor
//
//  Created by Gordon Aspin on 1/8/25.
//

import CoreMotion

@Observable
class MotionManager {
    
    var rollAngle: Double = 0
    var yawAngle: Double = 0
    var pitchAngle: Double = 0
    var isTracking: Bool = false
    private var motionManager = CMMotionManager()
    
    init() {
        print("\(Date().toTimestamp) - \(#file) \(#function) motion manager initialized")
        setupMotionManager()
    }
    
    private func setupMotionManager() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 1.0
        }
    }
    
    func startTracking() {
        print("\(Date().toTimestamp) - \(#file) \(#function) start tracking")
        if !isTracking {
            isTracking.toggle()
            
            motionManager.startDeviceMotionUpdates(to: .main) { [weak self] (motion, error) in
                guard let self = self, let motion = motion else { return }
                let gravity = motion.gravity
                let xSquared = gravity.x * gravity.x
                let ySquared = gravity.y * gravity.y
                let zSquared = gravity.z * gravity.z
                
                let xTiltAngle: Double = atan2(sqrt(ySquared + zSquared), gravity.x) * (180 / .pi)
                let yTiltAngle: Double = atan2(sqrt(xSquared + zSquared), gravity.y) * (180 / .pi)
                let zTiltAngle: Double = atan2(sqrt(xSquared + ySquared), gravity.z) * (180 / .pi)
                
                // Reduce accuracy to 1.0 degree
                let newRollAngle = 90.0 - round(xTiltAngle)
                let newYawAngle = round(yTiltAngle)
                let newPitchAngle = round(zTiltAngle) - 90.0
                
                // Don't publish new values if they have not changed
                if (newRollAngle != self.rollAngle) {
                    self.rollAngle = newRollAngle
                }
                if (newYawAngle != self.yawAngle) {
                    self.yawAngle = newYawAngle
                }
                if (newPitchAngle != self.pitchAngle) {
                    self.pitchAngle = newPitchAngle
                }
                print("\(Date().toTimestamp) - \(#file) roll/pitch/yaw updated rollAngle: \(rollAngle), pitchAngle: \(pitchAngle), yawAngle: \(yawAngle)")
            }
            
        }
    }
    
    func stopTracking() {
        print("\(Date().toTimestamp) - \(#file) \(#function) stop tracking")
        if isTracking {
            motionManager.stopDeviceMotionUpdates()
            isTracking.toggle()
        }
    }
}
