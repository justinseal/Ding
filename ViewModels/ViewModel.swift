// Created on 6/24/25.

import SwiftUI
import AVKit

enum TimerState {
    case active, paused, resumed, cancelled, finished
}

enum BellState {
    case running, stopped
}

final class ViewModel: ObservableObject {
    //MARK: Timer Variables
    @Published var selectedMinutes: Int = 0
    @Published var selectedSeconds: Int = 0
    @Published var secondsRemaining: Int = 0
    @Published var progress: CGFloat = 0.0
    @Published var selectedBellRingInterval: Int = 1
    @Published var audioPlayer: AVAudioPlayer!
    
//    @Published var selectedSound = "high"
    @Published var isPlaying = true
    
    //Timer variable specific for picking the time range
    private var totalCurrentTime: Int {
        (selectedMinutes * 60) + selectedSeconds
    }
    private var timer = Timer()
    
    @Published var state: TimerState = .cancelled {
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
//                playSound()
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
    
    func setBellTime() {
        let date = Date()
        let calendar = Calendar.current
        let currentMinutes = calendar.component(.minute, from: date)
        var ringTimeinSeconds = (selectedBellRingInterval + currentMinutes) * 60
        
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
            ringTimeinSeconds -= 1
        })
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
