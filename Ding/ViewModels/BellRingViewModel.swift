// Created on 6/24/25.

import SwiftUI
import AVKit



enum BellState {
    case running, stopped, repeating
}

final class BellRingViewModel: ObservableObject {
    //MARK: Timer Variables
    @Published var selectedMinutes: Int = 0
    @Published var selectedSeconds: Int = 0
    @Published var progress: CGFloat = 1.0
    
    @Published var soundModel = SoundPlayerViewModel()
    
    @AppStorage("bellSecondsRemaining") var secondsRemaining: Int = 1
    @AppStorage("ringAtStart") var ringAtStart: Bool = false
    @AppStorage("intervialRingTime") var intervialRingTime: Int = 1
    @AppStorage("randomInterval") var randomInterval: Bool = false
    @AppStorage("selectedSound") var selectedSound: SoundsList = .highShort

    
    
    //Timer variable specific for picking the time range
    private var totalTimeForSelection: Int {
        (selectedMinutes * 60) + selectedSeconds
    }
    private var timer = Timer()
    
    var randomIntervalSeconds: Int?
    
    @Published var state: BellState = .stopped {
        didSet {
            switch state {
            case .running:
                if ringAtStart {
                    soundModel.playSound(soundName: selectedSound.rawValue)
                }
                startBellTimer()
            
            case .stopped:
                timer.invalidate()
                
            case .repeating:
                if ringAtStart {
                    soundModel.playSound(soundName: selectedSound.rawValue)
                }
                randomBellTimer()
            }
        }
    }
    //MARK: Timer Ranges
    //TODO: Make a timer selector
    
    
    //MARK: Timer Functions
    func startBellTimer() {
        updateRemaningSeconds()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.secondsRemaining -= 1
            if self.secondsRemaining == 0 {
                self.timer.invalidate()
            }
            
        }
    }
    
    func startRandomTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.secondsRemaining -= 1
            
            if self.secondsRemaining <= 0 {
                self.timer.invalidate()
                self.randomBellTimer()
            }
        }
    }
    
    
    
    func createRandomIncrement() {
        randomIntervalSeconds = Int.random(in: 1...intervialRingTime)
        secondsRemaining = ((randomIntervalSeconds ?? 0 + intervialRingTime) * 60)
    }
    
    func updateRemaningSeconds() {
        secondsRemaining = intervialRingTime * 60
    }
    
    func randomBellTimer() {
        createRandomIncrement()
        startRandomTimer()
    }
}
