//
//  AeroCore.swift
//  YawLab
//
//  Created by Viktor Bán on 2026. 01. 11..
//

enum AeroCore {
    static func deg2rad(_ deg: Double) -> Double { AeroCoreBridge.deg2rad(deg) }
    static func rad2deg(_ rad: Double) -> Double { AeroCoreBridge.rad2deg(rad) }
}
