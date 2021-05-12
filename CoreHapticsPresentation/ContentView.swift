//
//  ContentView.swift
//  CoreHapticsPresentation
//
//  Created by Daniel Slone on 5/12/21.
//


import CoreHaptics
import SwiftUI

struct ContentView: View {

    @State private var engine: CHHapticEngine?

    var body: some View {
        Button(
            "Play haptic",
            action: playHaptic
        )
        .onAppear(perform: prepareHaptics)
    }

    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {
            return
        }

        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }

    func playHaptic() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {
            return
        }

        guard let path = Bundle.main.path(forResource: "haptic", ofType: "ahap") else {
            return
        }

        do {
            // Start the engine in case it's idle.
            try engine?.start()

            // Tell the engine to play a pattern.
            try engine?.playPattern(from: URL(fileURLWithPath: path))
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
