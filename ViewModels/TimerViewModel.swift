// Created on 7/21/25.

import SwiftUI
import AVKit

enum TimerState {
    case active, paused, resumed, cancelled, finished
}

final class TimerViewModel: ObservableObject {
    @AppStorage("selectedSound") var selectedSound: SoundsList = .highShort
    
    @Published var secondsRemaining: Int = 0
    @Published var progress: CGFloat = 0
    
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
                startMeditationTimer()
                secondsRemaining = totalTimeForSelection
                progress = 1.0
                
            case .paused:
                timer.invalidate()
                
            case .resumed:
                startMeditationTimer()
                
            case .cancelled:
                timer.invalidate()
                secondsRemaining = 0
                progress = 1.0
                
            case .finished:
                playSound(soundName: selectedSound.rawValue)
                timer.invalidate()
                progress = 1.0
                secondsRemaining = 0
                
            }
        }
    }
    
    private var totalTimeForSelection: Int {
        (selectedMinutes * 60) + selectedSeconds
    }
    
    private var timer = Timer()
    
    func startMeditationTimer() {
        secondsRemaining = totalTimeForSelection
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.secondsRemaining -= 1
            self.progress = CGFloat(self.secondsRemaining) / CGFloat(self.totalTimeForSelection)
            
            if self.secondsRemaining == 0 {
                self.playSound(soundName: self.selectedSound.rawValue)
                self.timer.invalidate()
            }
            
        }
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
