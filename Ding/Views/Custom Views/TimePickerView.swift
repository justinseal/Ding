// Created on 7/17/25.

import SwiftUI

struct TimePickerView: View {
    private let pickerPadding: CGFloat = 4.0
    let title: String
    let range: ClosedRange<Int>
    let binding: Binding<Int>
    
    var body: some View {
        HStack {
            Picker(title, selection: binding) {
                ForEach(range, id: \.self) { timeIncrement in
                    HStack {
                        Spacer()
                        Text("\(timeIncrement)")
                            .foregroundColor(.black)
                            .multilineTextAlignment(.trailing)
                    }
                }
            }
            .pickerStyle(InlinePickerStyle())
            .labelsHidden()
            
            Text(title)
                .fontWeight(.bold)
        }
    }
}

