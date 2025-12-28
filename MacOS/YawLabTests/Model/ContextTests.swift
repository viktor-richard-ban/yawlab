//
//  ContextTests.swift
//  YawLab
//
//  Created by Viktor Bán on 2025. 12. 28..
//

import Foundation
import Testing
@testable import YawLab

struct ContextYawTests {
    @Test
    func yaw_returnsNil_whenLapIsMissing() {
        let ctx = makeContext(lap: nil)
        #expect(ctx.yaw(at: 0) == nil)
    }
    
    @Test
    func yaw_returnsNil_whenTimeIsNotFound() {
        let lap = makeLap(
            times: [0, 1],
            speeds: [10, 10],
            positions: [
                CGPoint(x: 0, y: 0),
                CGPoint(x: 1, y: 0)
            ],
            wind: 0,
            windSpeed: 0
        )
        
        let ctx = makeContext(lap: lap)
        #expect(ctx.yaw(at: 2) == nil)
    }
    
    @Test
    func yaw_isExactlyZero_whenWindSpeedIsZero_andHeadingIsZero() throws {
        // Positions aligned on +X => heading should be exactly 0° (atan2(0, positive) == 0).
        // WindSpeed == 0 => wind vector is exactly zero regardless of wind direction.
        // Therefore relative airflow direction == heading => yaw == 0 exactly.
        let lap = makeLap(
            times: [0, 1],
            speeds: [10, 10],
            positions: [
                CGPoint(x: 0, y: 0),
                CGPoint(x: 10, y: 0)
            ],
            wind: 180, // direction irrelevant when windSpeedKph == 0
            windSpeed: 0
        )
        
        let ctx = makeContext(lap: lap)
        
        let yaw = try #require(ctx.yaw(at: 1))
        #expect(yaw == 0)
    }
    
    // MARK: - Helpers

    private func makeContext(lap: Lap? = nil) -> Context {
        let ctx = Context()
        ctx.lap = lap
        return ctx
    }

    private func makeLap(
        times: [Double],
        speeds: [Double],
        positions: [CGPoint],
        wind: Double,
        windSpeed: Double
    ) -> Lap {
        Lap(
            lapTime: times.last ?? 0,
            times: times,
            speeds: speeds,
            throttles: Array(repeating: 0, count: times.count),
            brakes: Array(repeating: false, count: times.count),
            positions: positions,
            wind: wind,
            windSpeed: windSpeed
        )
    }
}
