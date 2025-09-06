// Created on 6/27/25.

import SwiftUI

struct IncreaseTimeView: View {
    @AppStorage("intervialRingTime") var intervialRingTime: Int = 1
    @AppStorage("randomInterval") var randomInterval: Bool = false
   
    var body: some View {
        VStack(alignment: .leading) {
            Toggle("Ring on at random times", isOn: $randomInterval)
            if randomInterval {
                Text("Bell will ring randomly every \(intervialRingTime) minutes")
            } else {
                Text("The bell will ring every \(intervialRingTime) minutes")
                
            }

            Stepper("Set your Bell ring interval", onIncrement: {
                intervialRingTime += 5
            }, onDecrement: {
                intervialRingTime -= 5
            })
            .accessibilityLabel("This is a stepper to set your bell ring interval")
            .accessibilityHint("Use the plus button to increase your bell ring interval by 5 minutes, and use the minus button to decrease it by 5 minutes.")
            Button {
                intervialRingTime = 5
            } label: {
                Text("Reset Ring Interval")
            }
            .buttonStyle(.bordered)
        }
        .accessibilityLabel("Reset the ring interval to 5 minutes")
        .accessibilityHint("Use this button to reset the ring interval to 5 minutes.")
    }
}

#Preview {
    IncreaseTimeView()
}
