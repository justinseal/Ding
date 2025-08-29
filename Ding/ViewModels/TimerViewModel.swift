// Created on 7/21/25.

import SwiftUI
import AVKit

enum TimerState {
    case active, paused, resumed, cancelled, finished
}

final class TimerViewModel: ObservableObject {
    @AppStorage("selectedSound") var selectedSound: SoundsList = .highShort
    @AppStorage("selectedSeconds") var selectedSeconds: Int = 0
    @AppStorage("selectedMinutes") var selectedMinutes: Int = 0
    @AppStorage("selectedHours") var selectedHours: Int = 0
    
    @Published var secondsRemaining: Int = 0
    @Published var progress: CGFloat = 1.0
    
//    @Published var selectedMinutes: Int = 0
//    @Published var selectedSeconds: Int = 0
    @Published var soundmodel = SoundPlayerViewModel()
    
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
                soundmodel.playSound(soundName: selectedSound.rawValue)
                timer.invalidate()
                progress = 1.0
            }
        }
    }
    
    var totalTimeForSelection: Int {
        (selectedHours * 3600) + (selectedMinutes * 60) + selectedSeconds
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
    
    func resetTimes() {
        
        selectedHours = 0
        selectedMinutes = 0
        selectedSeconds = 0
    }
 
}
