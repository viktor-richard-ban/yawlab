//
//  Double+Degree.swift
//  YawLab
//
//  Created by Viktor Bán on 2025. 12. 28..
//

extension Double {
    func deg2rad() -> Double {
        AeroCore.deg2rad(self)
    }
    
    func rad2deg() -> Double {
        AeroCore.rad2deg(self)
    }
    
    func wrapTo180() -> Double {
        var x = (self + 180).truncatingRemainder(dividingBy: 360)
        if x < 0 { x += 360 }
        return x - 180
    }
}
