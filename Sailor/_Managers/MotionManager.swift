//
//  MotionManager.swift
//  Sailor
//
//  Created by Gordon Aspin on 1/8/25.
//

import CoreMotion

class MotionManager: NSObject, ObservableObject {
    static let shared = MotionManager()
    
    @Published var rollAngle: Int = 0
    @Published var yawAngle: Int = 0
    @Published var pitchAngle: Int = 0
    
    private var motionManager = CMMotionManager()
    
    private override init() {
        super.init()
        setupMotionManager()
    }
    
    private func setupMotionManager() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 0.2
            motionManager.startDeviceMotionUpdates(to: .main) { [weak self] (motion, error) in
                guard let self = self, let motion = motion else { return }
                //print("motionManager: motion update")
                let gravity = motion.gravity
                let xTiltAngle = atan2(sqrt(gravity.y * gravity.y + gravity.z * gravity.z), gravity.x) * (180 / .pi)
                let yTiltAngle = atan2(sqrt(gravity.x * gravity.x + gravity.z * gravity.z), gravity.y) * (180 / .pi)
                let zTiltAngle = atan2(sqrt(gravity.x * gravity.x + gravity.y * gravity.y), gravity.z) * (180 / .pi)
                self.rollAngle = 90 - Int(xTiltAngle)
                self.yawAngle = Int(yTiltAngle)
                self.pitchAngle = Int(zTiltAngle) - 90
            }
        }
    }
}
