// Created on 6/27/25.

import SwiftUI

struct IncreaseTimeView: View {
    @AppStorage("intervialRingTime") var intervialRingTime: Int = 1
    
    var body: some View {
        Text("The bell will ring every \(intervialRingTime) minutes")
        Stepper("Set your Bell ring interval", value: $intervialRingTime)
        
    }
}

#Preview {
    IncreaseTimeView()
}
