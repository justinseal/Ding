// Created on 7/21/25.

import SwiftUI
import AVKit

enum TimerState {
    case active, paused, resumed, cancelled, finished
}

final class TimerViewModel: ObservableObject {
    @AppStorage("selectedSound") var selectedSound: SoundsList = .highShort
    @Published var secondsRemaining: Int = 0
    @Published var progress: CGFloat = 1.0
    
    @Published var isPlaying = true
    @Published var selectedMinutes: Int = 0
    @Published var selectedSeconds: Int = 0
    @Published var audioPlayer: AVAudioPlayer!
    
    let hoursRange = 0...23
    let minutesRange = 0...59
    let secondsRange = 0...59
    
    @Published var state: TimerState = .cancelled {
        didSet {
            switch state {
                case .active:
                progress = 1.0
                startMeditationTimer()
                
            case .paused:
                timer.invalidate()
                
            case .resumed:
                startMeditationTimer()
                
            case .cancelled:
                timer.invalidate()
                progress = 1.0
                
            case .finished:
                playSound(soundName: selectedSound.rawValue)
                timer.invalidate()
                progress = 1.0
            }
        }
    }
    
    var totalTimeForSelection: Int {
        (selectedMinutes * 60) + selectedSeconds
    }
    
    private var timer = Timer()
    
    func startMeditationTimer() {
        secondsRemaining = totalTimeForSelection
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if self.secondsRemaining == 0 {
                self.state = .finished
            } else {
                self.secondsRemaining -= 1
                self.updateProgress()
            }
            
        }
    }
    
    func updateProgress() {
        progress = CGFloat(secondsRemaining) / CGFloat(totalTimeForSelection)
    }
    
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
