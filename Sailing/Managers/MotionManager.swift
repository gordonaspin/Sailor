//
//  MotionManager.swift
//  Sailing
//
//  Created by Gordon Aspin on 1/8/25.
//

import CoreMotion

@Observable
class MotionManager {
    private var motionManager = CMMotionManager()
    var rollAngle: Double = 0
    var yawAngle: Double = 0
    var pitchAngle: Double = 0
    
    init() {
        print("motion manager initialized")
        setupMotionManager()
    }
    
    private func setupMotionManager() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 0.2
            startTracking()
        }
    }
    
    func startTracking() {
        print("start tracking")

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
            
            var hasChanged: Bool = false
            // Don't publish new values if they have not changed
            if (newRollAngle != self.rollAngle) {
                self.rollAngle = newRollAngle
                hasChanged = true
            }
            if (newYawAngle != self.yawAngle) {
                self.yawAngle = newYawAngle
                hasChanged = true
            }
            if (newPitchAngle != self.pitchAngle) {
                self.pitchAngle = newPitchAngle
                hasChanged = true
            }
            if hasChanged {
                print("roll/pitch/yaw updated rollAngle:", "\(rollAngle)", "pitchAngle:", "\(pitchAngle)", "yawAngle:", "\(yawAngle)")
            }
        }
    }
    
    func stopTracking() {
        print("stop tracking")
        motionManager.stopDeviceMotionUpdates()
    }
}
