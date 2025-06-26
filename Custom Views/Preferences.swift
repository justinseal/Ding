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
    
    @StateObject private var model = ViewModel()
    
    var body: some View {
        List {
            Section("General") {
                Picker("Select a sound", selection: $selectedSound) {
                    ForEach(SoundsList.allCases, id: \.self) { sound in
                        Text(sound.rawValue)
                    }
                    .pickerStyle(.wheel)
                }
            }
        }
    }
}

#Preview {
    Preferences()
}
