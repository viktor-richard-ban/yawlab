//
//  Double+Time.swift
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
    
    /// Returns the time value from a list that is closest to self.
    ///
    /// This is commonly used with Swift Charts when converting a continuous X-axis
    /// value (such as one returned by `ChartProxy.value(atX:)`) into the nearest
    /// discrete data point.
    ///
    /// - Parameters:
    ///   - times: A collection of discrete time values representing actual data
    ///     points.
    /// - Returns: The value in `times` whose absolute distance to `self` is
    ///   minimal, or `nil` if the collection is empty.
    ///
    /// - Note: This implementation performs a linear search. For large, sorted
    ///   datasets, consider using a binary search–based approach for better
    ///   performance.
    func closestTime(
        in times: [Double]
    ) -> Double? {
        times.min { abs($0 - self) < abs($1 - self) }
    }
    
    func radiansToDegrees() -> Double {
        return self * 180.0 / .pi
    }
}
