//
//  Double+Degree.swift
//  YawLab
//
//  Created by Viktor Bán on 2025. 12. 28..
//

extension Double {
    func deg2rad() -> Double {
        self * .pi / 180.0
    }
    
    func rad2deg() -> Double {
        self * 180.0 / .pi
    }
    
    func wrapTo180() -> Double {
        var x = (self + 180).truncatingRemainder(dividingBy: 360)
        if x < 0 { x += 360 }
        return x - 180
    }
}
