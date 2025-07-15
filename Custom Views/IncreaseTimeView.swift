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
            Button {
                intervialRingTime = 5
            } label: {
                Text("Reset Ring Interval")
            }
            .buttonStyle(.bordered)
        }
        
    }
}

#Preview {
    IncreaseTimeView()
}
