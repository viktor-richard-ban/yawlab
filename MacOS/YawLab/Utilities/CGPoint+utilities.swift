//
//  CGPoint+utilities.swift
//  YawLab
//
//  Created by Viktor Bán on 2025. 12. 26..
//

import Foundation

extension Array where Element == CGPoint {
    /// Calculates the heading of the car from the current and the previous point
    /// Return: Directions in radians
    func directions() -> [Double] {
        guard !self.isEmpty else { return [] }

        var directions: [Double] = []
        func direction(point: CGPoint, prevPoint: CGPoint) -> Double {
            let dx = point.x - prevPoint.x
            let dy = point.y - prevPoint.y
            return atan2(-dy, dx) - .pi / 2 + .pi
        }
        
        for i in 1..<self.count {
            let direction = direction(point: self[i], prevPoint: self[i - 1])
            directions.append(direction)
        }
        let direction = direction(point: self[0], prevPoint: self[self.count - 1])
        directions.append(direction)
        return directions
    }
}
