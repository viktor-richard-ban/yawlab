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
    let laptime: Double
    let speed: [Double]
    let throttle: [Double]
    let brake: [Double]
    let position: [Position]
    let time: [Double]
    
    struct Position: Decodable {
        let x: [Double]
        let y: [Double]
    }
}
