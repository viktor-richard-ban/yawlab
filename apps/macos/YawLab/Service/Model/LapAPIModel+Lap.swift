//
//  LapAPIModel+Lap.swift
//  YawLab
//
//  Created by Viktor Bán on 2026. 02. 15..
//

extension LapAPIModel {
    func toDomain(wind: Double = 180, windSpeed: Double = 20) -> Lap {
        let xCoordinates = position.x
        let yCoordinates = position.y
        let positions = zip(xCoordinates, yCoordinates).map { CGPoint(x: $0.0, y: $0.1) }

        return Lap(
            lapTime: lapTime,
            times: time,
            speeds: speed,
            throttles: throttle,
            brakes: brake,
            positions: positions,
            wind: wind,
            windSpeed: windSpeed
        )
    }
}
