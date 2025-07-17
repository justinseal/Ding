// Created on 6/24/25.

import SwiftUI
import AVKit

enum TimerState {
    case active, paused, resumed, cancelled, finished
}

enum BellState {
    case running, stopped, repeating
}

final class ViewModel: ObservableObject {
    //MARK: Timer Variables
    @Published var selectedMinutes: Int = 0
    @Published var selectedSeconds: Int = 0
    @Published var secondsRemaining: Int = 1
    @Published var progress: CGFloat = 0.0
    @AppStorage("intervialRingTime") var intervialRingTime: Int = 1
    @AppStorage("randomInterval") var randomInterval: Bool = false
    @AppStorage("selectedSound") var selectedSound: SoundsList = .highShort
    @Published var audioPlayer: AVAudioPlayer!
//    @Published var selectedSound = "high"
    @Published var isPlaying = true
    
    //Timer variable specific for picking the time range
    private var totalCurrentTime: Int {
        (selectedMinutes * 60) + selectedSeconds
    }
    private var timer = Timer()
    
    var randomIntervalSeconds: Int?
    
    @Published var state: BellState = .stopped {
        didSet {
            switch state {
            case .running:
                startTimer()
            
            case .stopped:
                timer.invalidate()
                secondsRemaining = 0
                
            case .repeating:
                randomBellTimer()
            }
        }
    }
    //MARK: Timer Ranges
    //TODO: Make a timer selector
    let hoursRange = 0...23
    let minutesRange = 0...59
    let secondsRange = 0...59
    
    //MARK: Timer Functions
    func startTimer() {
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.secondsRemaining -= 1
            
            if self.secondsRemaining == 0 {
                self.playSound(soundName: self.selectedSound.rawValue)
                self.timer.invalidate()
            }
            
        }
    }
    
    func startRandomTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.secondsRemaining -= 1
            
            if self.secondsRemaining <= 0 {
                self.timer.invalidate()
                self.playSound(soundName: self.selectedSound.rawValue)
                self.randomBellTimer()
            }
        }
    }
    
    func createRandomIncrement() {
        randomIntervalSeconds = Int.random(in: 1...intervialRingTime)
        
    }
    
    func updateRemaningSeconds() {
        createRandomIncrement()
        secondsRemaining = ((randomIntervalSeconds ?? 0 + intervialRingTime) * 60)
    }
    
    func randomBellTimer() {
        updateRemaningSeconds()
        startRandomTimer()
    }
    
    func changeCircleProgress(for secondsRemaining: Int, totalCurrentTime: Int) -> CGFloat {
        progress = CGFloat(secondsRemaining) / CGFloat(totalCurrentTime)
        return progress
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
