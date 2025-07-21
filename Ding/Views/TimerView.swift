// Created on 6/27/25.

import SwiftUI

struct TimerView: View {
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
        .padding(.top, 80)
    }
        
    var timerPickerControll: some View {
        HStack {
            TimePickerView(title: "min", range: model.minutesRange, binding: $model.selectedMinutes)
            TimePickerView(title: "sec", range: model.secondsRange, binding: $model.selectedSeconds)
        }
        .frame(width: 360, height: 255)
        .padding(.all, 32)
    }
    
    var timerButtons: some View {
        HStack {
            Button("Stop") {
                model.state = .cancelled
            }
            .buttonStyle(StopButtonStyle())
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
