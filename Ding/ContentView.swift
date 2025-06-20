// Created on 6/18/25.

import SwiftUI
import AVFAudio

struct ContentView: View {
    @State private var audioPlayer: AVAudioPlayer!
    var sounds = ["high-short",
                  "high",
                  "low-bowl",
                  "low-bowl2",
                  "metal-mid",
                  "mid-bowl",
                  "mid-short",
                  "mid-short2"]
    @State private var selectedSound = "high"
    @State private var isPlaying = true
    
    var body: some View {
        VStack {
            Image("New Lotus")
                .resizable()
                .scaledToFit()
            Button {
                playSound()
            } label: {
                Label("Ring me", systemImage: "bell.and.waves.left.and.right.fill")
            }
            .buttonStyle(.borderedProminent)
            
            Picker("Select a sound", selection: $selectedSound) {
                ForEach(sounds, id: \.self) { sound in
                    Text(sound)
                }
                .pickerStyle(.wheel)
            }
        }
    }
    
    func playSound() {
        let soundName = selectedSound
        guard let soundFile = NSDataAsset(name: soundName) else { return }
        if isPlaying {
            do {
                audioPlayer = try AVAudioPlayer(data: soundFile.data)
                isPlaying.toggle()
                audioPlayer.play()
            } catch {
                print("😡 Error playing sound \(error.localizedDescription)")
            }
        } else {
            do {
                audioPlayer = try AVAudioPlayer(data: soundFile.data)
                audioPlayer.stop()
            } catch {
                print("😡 Error stoping sound \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    ContentView()
}
