//
//  Double+format.swift
//  YawLab
//
//  Created by Viktor Bán on 2025. 12. 25..
//

import Foundation

extension Double {
    
    /// Formats a duration as minutes, seconds, and milliseconds.
    /// Conditionally omit minutes when they are zero
    /// - Parameter seconds: The duration in seconds.
    /// - Returns: A string formatted as `mm:ss.sss`.
    var elapsedTime: String {
        let minutes = Int(self) / 60
        let remainingSeconds = self.truncatingRemainder(dividingBy: 60)
        if minutes > 0 {
            return String(format: "%02d:%06.3f", minutes, remainingSeconds)
        } else {
            return String(format: "%06.3f", remainingSeconds)
        }
    }
}
