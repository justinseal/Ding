// Created on 6/24/25.

import SwiftUI
import AVKit

enum TimerState {
    case active, paused, resumed, cancelled, finished
}

enum BellState {
    case running, stopped
}

@Observable
final class ViewModel {
    //MARK: Timer Variables
    var selectedMinutes: Int = 0
    var selectedSeconds: Int = 0
    var secondsRemaining: Int = 0
    var progress: CGFloat = 0.0
    var audioPlayer: AVAudioPlayer!
    var sounds = ["high-short",
                  "high",
                  "low-bowl",
                  "low-bowl2",
                  "metal-mid",
                  "mid-bowl",
                  "mid-short",
                  "mid-short2"]
    var selectedSound = "high"
    var isPlaying = true
    
    //Timer variable specific for picking the time range
    private var totalCurrentTime: Int {
        (selectedMinutes * 60) + selectedSeconds
    }
    private var timer = Timer()
    
    var state: TimerState = .cancelled {
        didSet {
            switch state {
            case .active:
                startTimer()
                secondsRemaining = totalCurrentTime
                progress = 1.0
            
            case .paused:
                timer.invalidate()
            
            case .resumed:
                startTimer()
                
            case .finished:
                playSound()
                timer.invalidate()
                progress = 1.0
                secondsRemaining = 0
                
            case .cancelled:
                timer.invalidate()
                secondsRemaining = 0
                progress = 1.0
            }
        }
    }
    
    let hoursRange = 0...23
    let minutesRange = 0...59
    let secondsRange = 0...59
    
    //MARK: Timer Functions
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
            self.secondsRemaining -= 1
            self.progress = CGFloat(self.secondsRemaining) / CGFloat(self.totalCurrentTime)
            
        })
    }
    
    func playSound() {
        let soundName = selectedSound
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
