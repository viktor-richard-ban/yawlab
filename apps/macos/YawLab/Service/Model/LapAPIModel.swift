//
//  LapAPIModel.swift
//  YawLab
//
//  Created by Viktor Bán on 2026. 02. 15..
//

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
}
