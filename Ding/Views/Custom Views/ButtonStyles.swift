// Created on 7/17/25.

import SwiftUI

struct StartButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 70, height: 70)
            .foregroundColor(.green)
            .background(.green).opacity(0.4)
            .clipShape(Circle())
            .padding(.all, 3)
            .overlay(
                Circle()
                    .stroke((Color.green)
                        .opacity(0.3), lineWidth: 2)
            )
    }
}

struct StopButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 70, height: 70)
            .foregroundColor(.red)
            .background(.red).opacity(0.4)
            .clipShape(Circle())
            .padding(.all, 3)
            .overlay(
                Circle()
                    .stroke((Color.red)
                        .opacity(0.3), lineWidth: 2)
            )
    }
}
