// Created on 6/18/25.

import SwiftUI
import AVFAudio

struct ContentView: View {
    @State private var audioPlayer: AVAudioPlayer!
    
    var body: some View {
        ZStack {
            VStack {
                Button("Ring Me") {
                    playSound()
                }
                
            }
        }
    }
    func playSound() {
        let soundName = "high1"
        guard let soundFile = NSDataAsset(name: soundName) else { return }
        do {
            audioPlayer = try AVAudioPlayer(data: soundFile.data)
            audioPlayer.play()
        } catch {
            print("😡 Error playing sound \(error.localizedDescription)")
        }
    }
}

#Preview {
    ContentView()
}
