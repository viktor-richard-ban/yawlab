//
//  TimeSeriesChartView.swift
//  YawLab
//
//  Created by Viktor Bán on 2025. 12. 25..
//

import Foundation

struct TelemetryPoint: Identifiable {
    let id = UUID()
    let time: Double   // seconds
    let value: Double  // e.g: speed in km/h, throttle in %
}
