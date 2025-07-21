// Created on 6/18/25.

import SwiftUI

struct BellRingView: View {
    @StateObject private var model = BellRingViewModel()
    @AppStorage("selectedSound") var selectedSound: SoundsList = .highShort
    @AppStorage("intervialRingTime") var intervialRingTime: Int = 5
    @AppStorage("randomInterval") var randomInterval: Bool = false
    @AppStorage("ringOnIntervial") var ringOnInterval: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Text("The Bell will ring in:")
                    Text(model.secondsRemaining.asTimeStamp)
                }
                    .font(.title)
                    .fontWeight(.bold)
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
                    HStack {
                        Button {
                            model.playSound(soundName: selectedSound.rawValue)
                            if model.state == .stopped {
                                model.state = .repeating
                            } else {
                                model.state = .stopped
                            }
                        } label: {
                            Label("Random interval", systemImage: "shuffle.circle")
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(!ringOnInterval)
                        
                        Button {
                            model.playSound(soundName: selectedSound.rawValue)
                            if model.state == .stopped {
                                model.state = .running
                            } else {
                                model.state = .stopped
                            }
                        } label: {
                            Label("Regular inverval", systemImage: "arrow.trianglehead.clockwise")
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    
                }
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
