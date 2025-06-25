// Created on 6/24/25.

import SwiftUI

struct CircleProgressView: View {
    let model = ViewModel()
    var lineWidth: CGFloat = 10
    @State private var chosenTime = Date.now
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(.gray.opacity(0.3), lineWidth: lineWidth)
            
            Circle()
                .trim(from: 0, to: model.progress)
                .stroke(.green, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .animation(.linear, value: model.progress)
            
            Text("\(Int(model.progress)) Minutes")
            
        }
        .frame(width: 300, height: 300)
    
    }
}

#Preview {
    CircleProgressView()
}
