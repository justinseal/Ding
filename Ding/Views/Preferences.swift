// Created on 6/26/25.

import SwiftUI

enum SoundsList: String, CaseIterable {
   case highShort = "high-short"
    case high = "high"
    case midBowl = "mid-bowl"
    case midShort = "mid-short"
    case midShort2 = "mid-short2"
    case lowBowl = "low-bowl"
    case lowBowl2 = "low-bowl2"
    case metalMid = "metal-mid"
}

struct Preferences: View {
    @AppStorage("selectedSound") var selectedSound: SoundsList = .highShort
    @AppStorage("ringOnIntervial") var ringOnInterval: Bool = false
    @AppStorage("randomInterval") var randomInterval: Bool = false
    @AppStorage("intervialRingTime") var intervialRingTime: Int = 5
    
    @StateObject private var model = BellRingViewModel()
    
    var body: some View {
        NavigationView {
            List {
                Section("General") {
                    Picker("Select a bell", selection: $selectedSound) {
                        ForEach(SoundsList.allCases, id: \.self) { sound in
                            Text(sound.rawValue)
                        }
                        .pickerStyle(.wheel)
                    }
                    Toggle("Ring on interval", isOn: $ringOnInterval)
                }
                Section("Interval Selections") {
                    IncreaseTimeView()
                }
                .disabled(!ringOnInterval)
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    Preferences()
}
