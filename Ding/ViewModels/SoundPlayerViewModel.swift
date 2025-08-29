// Created on 8/13/25.

import SwiftUI
import AVKit

final class SoundPlayerViewModel: ObservableObject {
    @AppStorage("selectedSound") var selectedSound: SoundsList = .highShort
    
    @Published var audioPlayer: AVAudioPlayer!
    @Published var isPlaying = true
    
    //MARK: Sound Player
    func playSound(soundName: String) {
        guard let soundFile = NSDataAsset(name: soundName) else { return }
            do {
                if isPlaying {
                    audioPlayer = try AVAudioPlayer(data: soundFile.data)
                    isPlaying.toggle()
                    audioPlayer.play()
                } else {
                    audioPlayer.stop()
                    isPlaying.toggle()
                }
            } catch {
                print("😡 Error playing sound \(error.localizedDescription)")
            }
        }
}
