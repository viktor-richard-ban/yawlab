//
//  LapAPIModel.swift
//  YawLab
//
//  Created by Viktor Bán on 2026. 02. 15..
//

import CoreGraphics

struct LapAPIModel: Decodable {
    let year: Int
    let event: String
    let session: String
    let driver: String
    let lapTime: Double
    let speed: [Double]
    let throttle: [Double]
    let brake: [Bool]
    let position: Position
    let time: [Double]

    enum CodingKeys: String, CodingKey {
        case year, event, session, driver, speed, throttle, brake, position, time
        case lapTime = "lap_time"
    }
    
    struct Position: Decodable {
        let x: [Double]
        let y: [Double]
    }

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
