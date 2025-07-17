// Created on 6/27/25.

import SwiftUI

struct AppTabView: View {
    
    var body: some View {
        TabView {
            Tab("Bell", systemImage: "bell.fill") {
                BellRingView()
            }
            Tab("Meditation", systemImage: "timer.circle.fill") {
                TimerView()
            }
            
            Tab("Settings", systemImage: "gear") {
                Preferences()
            }
        }
    }
}

#Preview {
    AppTabView()
}
