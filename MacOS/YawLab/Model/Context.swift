//
//  Context.swift
//  YawLab
//
//  Created by Viktor Bán on 2025. 12. 25..
//

import Foundation

@Observable
class Context {
    var year: String?
    var event: String?
    var circuit: Circuit?
    var session: String?
    var driver: String?
    var lap: Lap?
    var run: AeroReferencePack?
    var config: AeroReferencePack.Config?
    
    func yaw(at time: Double) -> Double? {
        guard let lap,
              let timeIndex = lap.speedTelemetryPoints.firstIndex(where: { $0.time == time }) else { return nil }
        let headingDeg = lap.positions.directions()[timeIndex]
        let windToDeg = lap.wind
        let carSpeed = lap.speeds[timeIndex]
        let windSpeed = lap.windSpeed
        
        let h = headingDeg.deg2rad()
        let w = windToDeg.deg2rad()
        
        // Velocity vectors in global XY
        let vCarX = carSpeed * cos(h)
        let vCarY = carSpeed * sin(h)
        
        let vWindX = windSpeed * cos(w)
        let vWindY = windSpeed * sin(w)
        
        // Relative wind felt by the car
        let vRelX = vCarX - vWindX
        let vRelY = vCarY - vWindY
        
        // Direction of the relative wind vector in global frame
        let relAngleDeg = atan2(vRelY, vRelX).rad2deg()
        
        // Yaw: relative airflow direction minus car heading
        return (relAngleDeg - headingDeg).wrapTo180()
    }
}
