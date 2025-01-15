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
    
    private var motionManager = CMMotionManager()
    
    init() {
        setupMotionManager()
    }
    
    private func setupMotionManager() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 0.2
            motionManager.startDeviceMotionUpdates(to: .main) { [weak self] (motion, error) in
                guard let self = self, let motion = motion else { return }
                let gravity = motion.gravity
                let xTiltAngle = atan2(sqrt(gravity.y * gravity.y + gravity.z * gravity.z), gravity.x) * (180 / .pi)
                let yTiltAngle = atan2(sqrt(gravity.x * gravity.x + gravity.z * gravity.z), gravity.y) * (180 / .pi)
                let zTiltAngle = atan2(sqrt(gravity.x * gravity.x + gravity.y * gravity.y), gravity.z) * (180 / .pi)
                self.rollAngle = 90 - xTiltAngle
                self.yawAngle = yTiltAngle
                self.pitchAngle = zTiltAngle - 90
            }
        }
    }
}
