// Created on 6/18/25.

import SwiftUI

struct BellRingView: View {
    @StateObject private var model = ViewModel()
    @AppStorage("selectedSound") var selectedSound: SoundsList = .highShort
    @AppStorage("intervialRingTime") var intervialRingTime: Int = 5
    @AppStorage("randomInterval") var randomInterval: Bool = false
    @AppStorage("ringOnIntervial") var ringOnInterval: Bool = false
    
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
                
                
                VStack {
                    Text("\(model.secondsRemaining) Seconds")
                    Button {
                        if model.state == .stopped && randomInterval == true {
                            model.state = .repeating
                        } else {
                            model.state = .stopped
                        }
                    } label: {
                        Label("Ring on an interval", systemImage: "arrow.trianglehead.clockwise")
                    }
                    .buttonStyle(.borderedProminent)
                }
                .disabled(!ringOnInterval)
                .labelsHidden()
                .navigationTitle("Just a Bell Ring")
            }
        }
        .onAppear {
            Task {
                model.updateRemaningSeconds()
            }
        }
    }
}

#Preview {
    BellRingView()
}
