// Created on 6/24/25.

import SwiftUI

struct CircleProgressView: View {
    @StateObject var model: TimerViewModel
    var lineWidth: CGFloat = 15
    
    var body: some View {
        ZStack {
            Image("New Lotus")
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
            Circle()
                .stroke(.gray.opacity(0.3), lineWidth: lineWidth)
            
            Circle()
                .trim(from: 0, to: model.progress)
                .stroke(.black, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .animation(.linear(duration: 1), value: model.secondsRemaining)
            
            Text(model.secondsRemaining.asTimeStamp)
                .font(.largeTitle)
                .fontWeight(.bold)
            
        }
        .frame(width: 350, height: 350)
    }
}

#Preview {
    CircleProgressView(model: TimerViewModel.init())
}
