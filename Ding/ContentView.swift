// Created on 6/18/25.

import SwiftUI

struct ContentView: View {
    @StateObject private var model = ViewModel()
    @AppStorage("selectedSound") var selectedSound: SoundsList = .highShort
    
    var body: some View {
        NavigationView {
            VStack {
                Image("New Lotus")
                    .resizable()
                    .scaledToFit()
                Button {
                    model.playSound(soundName: selectedSound.rawValue)
                } label: {
                    if model.isPlaying {
                        Label("Ring me", systemImage: "bell.and.waves.left.and.right.fill")
                    } else {
                        Label("Stop", systemImage: "stop.circle.fill")
                    }
                }
                .buttonStyle(.borderedProminent)
                Picker("Select a sound", selection: $selectedSound) {
                    ForEach(SoundsList.allCases, id: \.self) { sound in
                        Text(sound.rawValue)
                    }
                }
                .pickerStyle(.menu)
                
                VStack {
                    HStack {
                        
                        Text("The bell will ring every \(model.selectedBellRingInterval) minutes")
                        Stepper("Set your Bell ring interval", value: $model.selectedBellRingInterval)
                        
                    }
                    .padding()
                    Button {
                        model.setBellTime()
                    } label: {
                        Label("Ring on an interval", systemImage: "arrow.trianglehead.clockwise")
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .labelsHidden()
            .navigationTitle("Just a Bell Ring")
        }
    }
}

#Preview {
    ContentView()
}
