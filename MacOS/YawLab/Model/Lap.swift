//
//  Lap.swift
//  YawLab
//
//  Created by Viktor Bán on 2025. 12. 26..
//

import Foundation

struct Lap {
    /// in seconds
    let lapTime: Double
    let times: [Double]
    let speeds: [Double]
    let throttles: [Double]
    let brakes: [Bool]
    let positions: [CGPoint]
    
    // MARK: - Telemetry points
    var speedTelemetryPoints: [TelemetryPoint<Double>] {
        let n = min(times.count, speeds.count)
        return (0..<n).map { TelemetryPoint(time: times[$0], value: speeds[$0]) }
    }

    var throttleTelemetryPoints: [TelemetryPoint<Double>] {
        let n = min(times.count, throttles.count)
        return (0..<n).map { TelemetryPoint(time: times[$0], value: throttles[$0]) }
    }

    var brakeTelemetryPoints: [TelemetryPoint<Double>] {
        let n = min(times.count, brakes.count)
        return (0..<n).map {
            let value: Double = brakes[$0] == true ? 1.0 : 0.0
            return TelemetryPoint(time: times[$0], value: value)
        }
    }

    var positionsTelemetryPoints: [TelemetryPoint<CGPoint>] {
        return (0..<times.count).map {
            return TelemetryPoint<CGPoint>(time: times[$0], value: positions[$0])
        }
    }

    var directionTelemetryPoints: [TelemetryPoint<Double>] {
        let directions = positions.directions()
        return (0..<times.count).map {
            return TelemetryPoint<Double>(time: times[$0], value: directions[$0])
        }
    }

}
