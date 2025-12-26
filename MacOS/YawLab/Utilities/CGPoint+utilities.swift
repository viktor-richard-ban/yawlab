//
//  CGPoint+utilities.swift
//  YawLab
//
//  Created by Viktor Bán on 2025. 12. 26..
//

import Foundation

extension Array where Element == CGPoint {
    func directions() -> [Double] {
        guard !self.isEmpty else { return [] }

        var directions: [Double] = []
        for i in 1..<self.count {
            let dx = self[i].x - self[i - 1].x
            let dy = self[i].y - self[i - 1].y
            directions.append(atan2(dy, dx))
        }
        let dx = self[self.count - 1].x - self[0].x
        let dy = self[self.count - 1].y - self[0].y
        directions.append(atan2(dy, dx))
        return directions
    }
}
