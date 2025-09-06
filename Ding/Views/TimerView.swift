// Created on 6/27/25.

import SwiftUI

struct TimerView: View {
    @AppStorage("selectedSeconds") var storedSeconds: Int = 0
    @AppStorage("selectedMinutes") var storedMinutes: Int = 0
    
    @StateObject private var model = TimerViewModel()
    
    var body: some View {
        VStack {
            
            if model.state == .cancelled {
                timerPickerControll
            } else {
                progressView
            }
            timerButtons
        }
        .frame(maxWidth: .infinity, maxHeight: 300)
        
    }
    
    var progressView: some View {
        VStack {
            CircleProgressView(model: model)
        }
        .frame(width: 360, height: 250)
        .padding(.bottom, 80)
    }
        
    var timerPickerControll: some View {
        HStack {
            TimePickerView(title: "hour", range: model.hoursRange, binding: $model.selectedHours)
            TimePickerView(title: "min", range: model.minutesRange, binding: $model.selectedMinutes)
            TimePickerView(title: "sec", range: model.secondsRange, binding: $model.selectedSeconds)
        }
        .frame(width: 360, height: 255)
        .padding(.top, 32)
        
    }
    
    var timerButtons: some View {
        HStack {
            Button("Stop") {
                model.state = .cancelled
            }
            .buttonStyle(StopButtonStyle())
            Spacer()
            
            Button("Reset") {
                withAnimation(.linear(duration: 0.3)) {
                    model.resetTimes()
                }
            }
            .buttonStyle(ResetButtonStyle())
            Spacer()
            
            switch model.state {
            case .cancelled, .finished:
                Button("Start") {
                    model.state = .active
                }
                .buttonStyle(StartButtonStyle())
                
            case .active, .resumed:
                Button("Pause") {
                    model.state = .paused
                }
                .buttonStyle(StartButtonStyle())
                
                case .paused:
                Button("Resume") {
                    model.state = .resumed
                }
                .buttonStyle(StartButtonStyle())
            }
        }
        .padding(.all, 32)
    }
}

#Preview {
    TimerView()
}
