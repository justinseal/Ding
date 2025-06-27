// Created on 6/18/25.

import SwiftUI

struct BellRingView: View {
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
                
                
                VStack {
                    Button {
                        model.setBellTime()
                    } label: {
                        Label("Ring on an interval", systemImage: "arrow.trianglehead.clockwise")
                    }
                    .buttonStyle(.borderedProminent)
                    
                }
                .labelsHidden()
                .navigationTitle("Just a Bell Ring")
            }
        }
    }
}

#Preview {
    BellRingView()
}
