// Created on 7/17/25.

import Foundation

extension Int {
    var asTimeStamp: String {
        let hour = self / 3600
        let minute = self / 60 % 60
        let second = self % 60
        
        return String(format: "%02i:%02i:%02i", hour, minute, second)
    }
}
