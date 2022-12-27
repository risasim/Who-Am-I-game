//
//  SwiftUIView.swift
//  WhoAmIGame
//
//  Created by Richard on 04.12.2022.
//

import SwiftUI

import SwiftUI
import CoreMotion

struct HeadsUp: View {
    let words = [
        "apple",
        "banana",
        "orange",
        "grape",
        "strawberry"
    ]

    @State private var currentWordIndex = 0

    // Use CoreMotion to track the device's attitude (roll, pitch, and yaw)
    let motion = CMMotionManager()
    @State private var deviceAttitude: CMAttitude?

    var body: some View {
        VStack {
            Text("Guess the word:")
                .font(.title)

            Text(words[currentWordIndex])
                .font(.body)
                .onAppear(perform: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
        }
    }
    func other(){
        // Display the device's current attitude
        if let attitude = deviceAttitude {
            Text("Roll: \(attitude.roll), Pitch: \(attitude.pitch), Yaw: \(attitude.yaw)")
        }

        if currentWordIndex < words.count {
            // Start tracking the device's attitude when the game starts
            if motion.isDeviceMotionAvailable {
                motion.startDeviceMotionUpdates(using: .xMagneticNorthZVertical)

                motion.deviceMotionUpdateInterval = 0.1
                motion.showsDeviceMovementDisplay = true

                // Update the device's attitude as it changes
                motion.deviceMotionUpdateInterval = 1 / 30
                motion.startDeviceMotionUpdates(using: .xMagneticNorthZVertical, to: .main) { (data, error) in
                    self.deviceAttitude = data?.attitude
                }
            }
        }

        if currentWordIndex >= words.count {
            Text("You win!")

            // Stop tracking the device's attitude when the game ends
            motion.stopDeviceMotionUpdates()
        }
    }
}


struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        HeadsUp()
    }
}
