//
//  TimeSeriesChartView.swift
//  YawLab
//
//  Created by Viktor Bán on 2025. 12. 25..
//

import Foundation

struct TelemetryPoint<T>: Identifiable {
    let id = UUID()
    let time: Double   // seconds
    let value: T  // e.g: speed in km/h, throttle in %
}
