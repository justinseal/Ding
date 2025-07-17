// Created on 6/27/25.

import SwiftUI

struct TimerView: View {
    @StateObject private var model = ViewModel()
    
    var body: some View {
        //TODO: Fix this view to not mess with the top
        VStack {
            
            progressView
            timerPickerControll
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
                //TODO: insert button action
            }
            .buttonStyle(StopButtonStyle())
            Spacer()
            
            Button("Start") {
                //TODO: insert button action
                model.startMeditationTimer()
            }
            .buttonStyle(StartButtonStyle())
        }
        .padding(.all, 32)
    }
}

#Preview {
    TimerView()
}
